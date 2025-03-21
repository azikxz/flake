{
  pkgs,
  lib,
  config,
  ...
}:

with lib;
with x;
let
  cfg = config.module.services.torrserver;
in

{
  options = {
    module.services.torrserver = {
      enable = mkBool false;
      port = mkStr "8090";
      disk = mkPath "/var/lib/torrserver";
    };
  };

  config = mkIf cfg.enable {
    systemd.services = {
      torrserver = {
        enable = true;
        after = [
          "network.target"
          "multi-user.target"
        ];
        wantedBy = [
          "multi-user.target"
        ];
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
            -d ${cfg.disk} \
            -p ${cfg.port}
          '';
        };
      };
    };
  };
}
