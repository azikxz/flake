{
  self,
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
      user = mkStr "torrserver";
      group = mkStr "torrserver";
      port = mkStr "8090";
      disk = mkPath "/var/lib/torrserver";
    };
  };

  config = mkIf cfg.enable {
    systemd.services = {
      torrserver = {
        enable = true;
        after = [
          "multi-user.target"
          "network.target"
        ];
        wantedBy = [
          "multi-user.target"
        ];
        serviceConfig = {
          ExecStart = "${
            getExe' self.packages.${pkgs.system}.torrserver "torrserver"
          } -d ${cfg.disk} -p ${cfg.port}";
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
    users = {
      groups.${cfg.user} = { };
      users.${cfg.user} = {
        group = cfg.user;
        home = cfg.disk;
        isSystemUser = true;
      };
    };
  };
}
