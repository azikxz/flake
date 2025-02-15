{
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
      enable = mkBool false;
    };
  };

  config = mkIf cfg.enable {
    hardware.system76 = {
      enableAll = on;
      power-daemon = on;
      firmware-daemon = on;
      kernel-modules = on;
    };
    services.system76-scheduler = on // {
      settings = {
        cfsProfiles = on;
        processScheduler.pipewireBoost = on;
      };
    };
  };
}
