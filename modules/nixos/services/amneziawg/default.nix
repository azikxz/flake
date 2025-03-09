{
  pkgs,
  lib,
  config,
  ...
}:

with lib;
with x;
let
  inherit (pkgs) amneziawg-tools amneziawg-go;
  cfg = config.module.services.amneziawg;
  mk = n: "sudo ${getExe' amneziawg-tools "awg-quick"} ${n} warp";
in

{
  options = {
    module.services.amneziawg = {
      enable = mkBool false;
      service.enable = mkBool false;
      config = mkPath ./warp.conf;
    };
  };

  config = mkIf cfg.enable {
    environment = {
      etc."amnezia/amneziawg/warp.conf".source = cfg.config;
      shellAliases = {
        awgUp = mk "up";
        awgDown = mk "down";
      };
      systemPackages = [
        amneziawg-tools
        amneziawg-go
      ];
    };
    boot.extraModulePackages = with config.boot.kernelPackages; [ amneziawg ];
    systemd.services.warp = mkIf cfg.service.enable {
      enable = true;
      after = [ "network.target" ];
      wantedBy = [ "multi-user.target" ];
      path = [ amneziawg-go ];
      serviceConfig = {
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
