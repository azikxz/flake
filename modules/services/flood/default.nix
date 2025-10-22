{
  pkgs,
  lib,
  config,
  ...
}:

with lib;
let
  cfg = config.services.qbittorrent;
in
# http://localhost:8085

mkIf config.services.qbittorrent.enable {
  persist.dirs = [ "/var/lib/flood" ];

  systemd.services.flood =
    (genAttrs [
      "after"
      "wantedBy"
    ] (n: [ "qbittorrent.service" ]))
    // {
      path = with pkgs; [ mediainfo ];

      serviceConfig = {
        Type = "simple";

        User = "flood";
        Group = "flood";

        StateDirectory = [ "flood" ];
        StateDirectoryMode = mkDefault 775;

        ExecStart = concatStringsSep " " [
          (getExe pkgs.flood)
          "--auth none"
          "--rundir /var/lib/flood"
          "--host 127.0.0.1"
          "--port 8085"
          "--qburl http://localhost:${toString cfg.webuiPort}"
          "--qbuser ${system.userName}"
          "--qbpass simplepassword"
        ];
      };
    };

  users = {
    groups.flood = { };

    users.flood = {
      isSystemUser = true;

      group = "flood";
    };
  };

  networking.firewall = {
    allowedTCPPorts = [ 8085 ];
  };
}
