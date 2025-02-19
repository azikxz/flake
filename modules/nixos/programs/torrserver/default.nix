{
  inputs,
  lib,
  config,
  ...
}:

with lib;
with x;
let
  cfg = config.module.programs.torrserver;
in

{
  options = {
    module.programs.torrserver = {
      enable = mkBool false;
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
        wantedBy = [ "multi-user.target" ];
        serviceConfig = {
          ExecStart = "${inputs.xpk.pkgs.torrserver}/bin/torrserver";
          Restart = "on-failure";
          Type = "simple";
          TimeoutSec = 30;
        };
      };
    };
  };
}
