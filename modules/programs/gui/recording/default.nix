{
  pkgs,
  lib,
  config,
  ...
}:

with lib;
# INFO: set theme in settings
# and wf-recorded

mkIf (mac "pcRyazenka" || mac "thinkpadT14") {
  environment.systemPackages = with pkgs; [
    wf-recorder
    (writeShellScriptBin "wf-rec" ''
      wf-recorder -r 60 -a \
        -f "$HOME/Videos/Screencasts/$(date +'%Y%m%dT%H%M%S').mp4"
    '')
  ];

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
