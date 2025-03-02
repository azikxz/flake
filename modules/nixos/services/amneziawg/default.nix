{
  pkgs,
  lib,
  config,
  ...
}:

with lib;
with x;
let
  cfg = config.module.services.amneziawg;
in

{
  options = {
    module.services.amneziawg = {
      enable = mkBool false;
      config = mkPath ./warp.conf;
    };
  };

  config = mkIf cfg.enable {
    environment = {
      etc."amnezia/amneziawg/warp.conf".source = cfg.config;
      systemPackages = with pkgs; [
        amneziawg-tools
        amneziawg-go
      ];
    };
    boot.extraModulePackages = with config.boot.kernelPackages; [ amneziawg ];
    systemd.services.warp = with pkgs; {
      enable = true;
      after = [ "network.target" ];
      wantedBy = [ "multi-user.target" ];
      path = [ amneziawg-go ];
      serviceConfig =
        let
          mk = type: "${getExe' amneziawg-tools "awg-quick"} ${type} warp";
        in
        {
          Type = "oneshot";
          Restart = "on-failure";
          RestartSec = "5s";
          ExecStart = mk "up";
          ExecStop = mk "down";
          RemainAfterExit = "yes";
        };
    };
  };
}
