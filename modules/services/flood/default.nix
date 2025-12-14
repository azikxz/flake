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
# INFO:
# best webui for qbittorrent
#
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
          "--host 0.0.0.0"
          "--port 8113"
          "--qburl http://${cfg.serverConfig.Preferences.WebUI.Address}:${toString cfg.webuiPort}"
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
}
