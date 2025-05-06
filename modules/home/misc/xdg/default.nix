{
  pkgs,
  lib,
  config,
  ...
}:

with lib;
with x;

{
  options.module.misc.xdg = {
    enable = mkBool false;
  };

  config = {
    impermanence.dirs = [
      "Desktop"
      "Documents"
      "Downloads"
      "Music"
      "Pictures"
      "Videos"
      "Study"
    ];
    home.packages = [ pkgs.xdg-user-dirs ];
    xdg = {
      mime = on;
      mimeApps =
        on
        // import ./mimeApps.nix {
          inherit
            lib
            ;
        };
      portal = on // {
        config.common.default = [ "gtk" ];
        extraPortals = with pkgs; [
          xdg-desktop-portal-gtk
          xdg-desktop-portal-hyprland
        ];
      };
      userDirs =
        let
          mk = config.home.homeDirectory;
        in
        on
        // rec {
          # xdg default
          desktop = mk + "/Desktop";
          documents = mk + "/Documents";
          download = mk + "/Downloads";
          music = mk + "/Music";
          pictures = mk + "/Pictures";
          publicShare = mk + "/";
          templates = mk + "/";
          videos = mk + "/Videos";
          createDirectories = true;
          extraConfig = {
            XDG_STUDY_DIR = mk + "/Study";
            XDG_SCREENSHOTS_DIR = pictures + "/Screenshots";
          };
        };
      desktopEntries =
        let
          mk = name: {
            inherit name;
            noDisplay = true;
          };
        in
        {
          # qt
          qt5ct = mk "qt5ct";
          qt6ct = mk "qt6ct";
          # cli
          nvtop = mk "nvtop";
          btop = mk "btop";
          fish = mk "fish";
          # shit
          rofi = mk "rofi";
          rofi-theme-selector = mk "rofi-theme-selector";
          # office
          base = mk "base";
          calc = mk "calc";
          draw = mk "draw";
          impress = mk "impress";
          math = mk "math";
          writer = mk "writer";
        };
    };
  };
}
