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
      user = mkStr "media";
      group = mkStr "media";
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
          ExecStart = ''
            ${getExe' pkgs.torrserver "torrserver"} -d ${cfg.disk} -p ${cfg.port}
          '';
          Restart = "on-failure";
          Type = "simple";
          TimeoutSec = 30;
          User = cfg.user;
          Group = cfg.group;
          StateDirectory = [ "torrserver" ];
          StateDirectoryMode = mkDefault 777;
        };
      };
    };
  };
}
