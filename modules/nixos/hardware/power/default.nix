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
    services.upower = on;
    powerManagement = on // {
      powertop = on;
    };
  };
}
