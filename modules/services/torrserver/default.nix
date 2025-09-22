{
  pkgs,
  lib,
  ...
}:

with lib;
# http://localhost:8090

mkIf (mac "pcRyazenka" || mac "thinkpadT14") {
  persist.dirs = [ "/var/lib/torrserver" ];

  systemd.services = {
    torrserver = {
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
          ${getExe pkgs.self'.torrserver} \
          -d /var/lib/torrserver \
          -p 8090
        '';
      };
    };
  };

  networking.firewall = {
    allowedTCPPorts = [ 8090 ];
  };
}
