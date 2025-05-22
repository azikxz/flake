{
  pkgs,
  lib,
  ...
}:

with lib;

mkIf (itIs == "desktop") {
  hm.programs.obs-studio = {
    enable = true;

    plugins = with pkgs.obs-studio-plugins; [
      obs-pipewire-audio-capture
      obs-multi-rtmp
      obs-vkcapture
      input-overlay
      wlrobs
    ];
  };
}
