{
  pkgs,
  lib,
  config,
  ...
}:

with lib;
with x;
let
  cfg = config.module.programs.gui.obs;
in

{
  options = {
    module.programs.gui.obs = {
      enable = mkBool false;
    };
  };

  config = mkIf cfg.enable {
    programs.obs-studio = on // {
      plugins = with pkgs.obs-studio-plugins; [
        obs-pipewire-audio-capture
        obs-multi-rtmp
        obs-vkcapture
        input-overlay
        wlrobs
      ];
    };
  };
}
