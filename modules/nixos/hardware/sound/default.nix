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
    security.rtkit = True;
    services.pipewire = True // {
      pulse = True;
      wireplumber = True;
      alsa = True // {
        support32Bit = true;
      };
      lowLatency = True // {
        quantum = 64;
        rate = 48000;
      };
    };
  };
}
