{
  pkgs,
  lib,
  config,
  ...
}:

with lib;

mkIf config.services.qbittorrent.enable {
  persist.dirs = [ "/var/lib/flood" ];

  systemd.services.flood = {
    after = [ "network.target" ];
    wantedBy = [ "multi-user.target" ];

    serviceConfig = {
      Type = "simple";

      User = "flood";
      Group = "flood";

      StateDirectory = [ "flood" ];
      StateDirectoryMode = mkDefault 775;

      ExecStart = ''
        ${getExe pkgs.flood} --auth "none" \
        --rundir /var/lib/flood \
        --host "127.0.0.1" \
        --port 8085 \
        --qburl "http://localhost:8080 \
        --qbuser "pirate" \
        --qbpass "yoho"
      '';
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
