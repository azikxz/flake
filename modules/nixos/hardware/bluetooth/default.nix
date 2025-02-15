{
  pkgs,
  lib,
  config,
  ...
}:

with lib;
with x;
let
  cfg = config.module.hardware.bluetooth;
in

{
  options = {
    module.hardware.bluetooth = {
      enable = mkBool false;
    };
  };

  config = mkIf cfg.enable {
    hardware.bluetooth = on // {
      powerOnBoot = true;
    };
    environment.systemPackages = with pkgs; [
      bluetuith
      bluetooth_battery
    ];
  };
}
