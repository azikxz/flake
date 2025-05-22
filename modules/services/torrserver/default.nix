{
  pkgs,
  lib,
  ...
}:

with lib;

mkIf (itIs == "desktop") {
  systemd.services = {
    torrserver = {
      enable = true;

      after = [ "network.target" ];

      wantedBy = [ "multi-user.target" ];

      serviceConfig = {
        Restart = "on-failure";
        Type = "simple";
        TimeoutSec = 30;

        User = "media";
        Group = "media";

        StateDirectory = [ "torrserver" ];
        StateDirectoryMode = mkDefault 775;

        ExecStart = ''
          ${getExe' pkgs.torrserver "torrserver"} \
          -d /var/lib/torrserver \
          -p 8090
        '';
      };
    };
  };
}
