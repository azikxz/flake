{
  x,
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
      enable = mkBool;
    };
  };

  config = mkIf cfg.enable {
    hardware.bluetooth = True // {
      # BLUETOOTH LOL
      powerOnBoot = true;
    };
    environment.systemPackages = with pkgs; [
      # TUI FOR BLUETOOTH
      bluetuith
      bluetooth_battery
    ];
  };
}
