{
  pkgs,
  lib,
  config,
  ...
}:

with lib;

mkIf (mac "pcRyazenka") {
  hm = {
    programs.obs-studio = {
      enable = true;

      plugins = with pkgs.obs-studio-plugins; [
        input-overlay
        obs-backgroundremoval
        obs-multi-rtmp
        obs-pipewire-audio-capture
        obs-vaapi
        obs-vkcapture
        wlrobs
      ];
    };

    xdg.configFile = {
      "obs-studio/themes/stylix.ovt".text = import ./ovt.nix {
        inherit
          config
          ;
      };

      "obs-studio/themes/stylix.obt".text = import ./obt.nix;
    };
  };
}
