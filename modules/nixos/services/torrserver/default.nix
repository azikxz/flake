{
  inputs,
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
      port = mkStr "8080";
      dir = mkPath "/var/lib/torrserver";
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
          ExecStart = "${getExe' inputs.xpk.torrserver "torrserver"} -d ${cfg.dir} -p ${cfg.port}";
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
        home = cfg.dir;
        isSystemUser = true;
      };
    };
  };
}
