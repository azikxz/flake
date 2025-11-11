{
  pkgs,
  lib,
  config,
  ...
}:

with lib;
let
  inherit (config.hm.xdg.userDirs)
    videos
    ;

  savePath = videos + "/videocasts";
in
# INFO:
# set theme in settings
# ...
# with wf-recorded

mkIf (mac "pcRyazenka" || mac "thinkpadT14") {
  hmPackages = [ pkgs.wf-recorder ];

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

  tmp.wf-rec = {
    "${savePath}/"."d" = {
      user = system.userName;
      group = "users";

      mode = "0775";
    };
  };
}
