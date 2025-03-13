{
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
      enable = mkBool false;
    };
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [ pulsemixer ];
    security.rtkit = on;
    services.pipewire = on // {
      pulse = on;
      wireplumber = on;
      alsa = on // {
        support32Bit = true;
      };
      extraConfig.pipewire."92-low-latency" = {
        "context.properties" = {
          "default.clock.rate" = 48000;
          "default.clock.quantum" = 32;
          "default.clock.min-quantum" = 32;
          "default.clock.max-quantum" = 32;
        };
      };
    };
  };
}
