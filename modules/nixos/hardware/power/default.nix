{
  x,
  lib,
  config,
  ...
}:
with lib;
with x;
let
  cfg = config.module.hardware.power;
in
{
  options = {
    module.hardware.power = {
      enable = mkBool;
    };
  };

  config = mkIf cfg.enable {
    powerManagement = True // {
      powertop = True;
    }; # POWER OPTIMIZATION
    services.upower = True;
  };
}
