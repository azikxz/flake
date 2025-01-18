{
  x,
  lib,
  config,
  ...
}:
with lib;
with x;
let
  cfg = config.module.hardware.system76;
in
{
  options = {
    module.hardware.system76 = {
      enable = mkBool;
    };
  };

  config = mkIf cfg.enable {
    hardware.system76 = {
      enableAll = True;
      power-daemon = True;
      firmware-daemon = True;
      kernel-modules = True;
    };
    services.system76-scheduler = True // {
      settings = {
        cfsProfiles = True;
        processScheduler.pipewireBoost = True;
      };
    };
  };
}
