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
    impermanence.dirs = [ "/var/lib/bluetooth" ];
    environment.systemPackages = with pkgs; [ bluetui ];
    hardware.bluetooth = on // {
      powerOnBoot = true;
      settings = {
        General = {
          Experimental = true;
          Enable = "Source,Sink,Media,Socket";
        };
      };
    };
  };
}
