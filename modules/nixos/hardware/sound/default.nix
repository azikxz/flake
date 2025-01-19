{
  x,
  inputs,
  pkgs,
  lib,
  config,
  ...
}:
with lib;
with x;
let
  cfg = config.module.hardware.sound;
in
{
  options = {
    module.hardware.sound = {
      enable = mkBool;
    };
  };

  imports = with inputs; [ gaming.nixosModules.pipewireLowLatency ];
  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [ pulsemixer ];
    security.rtkit = on;
    services.pipewire = on // {
      pulse = on;
      wireplumber = on;
      alsa = on // {
        support32Bit = true;
      };
      lowLatency = on // {
        quantum = 64;
        rate = 48000;
      };
    };
  };
}
