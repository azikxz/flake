{
  pkgs,
  lib,
  config,
  ...
}:

with lib;
with x;
let
  cfg = config.module.services.flood;
in

{
  options = {
    module.services.flood = {
      enable = mkBool false;
      dir = mkPath "/var/lib/flood";
      port = mkPort 8085;
      qbit = {
        url = mkStr "localhost:8080";
        user = mkStr "pirate";
        pass = mkStr "yoho";
      };
      #
      user = mkStr "flood";
      group = mkStr "flood";
      mode = mkStr "775";
    };
  };

  config = mkIf cfg.enable {
    systemd.services.flood = {
      after = [ "network.target" ];
      wantedBy = [ "multi-user.target" ];
      serviceConfig = {
        Type = "simple";
        User = cfg.user;
        Group = cfg.group;
        StateDirectory = [ "flood" ];
        StateDirectoryMode = mkDefault 775;
        ExecStart = ''
          ${getExe pkgs.flood} --auth "none" \
          --rundir ${cfg.dir} \
          --host "127.0.0.1" \
          --port "${toString cfg.port}" \
          --qburl "http://${cfg.qbit.url}" \
          --qbuser "${cfg.qbit.user}" \
          --qbpass "${cfg.qbit.pass}"
        '';
      };
    };
    users = {
      groups.${cfg.group} = { };
      users.${cfg.user} = {
        isSystemUser = true;
        group = cfg.group;
      };
    };
  };
}
