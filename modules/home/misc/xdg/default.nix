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
        on
        // {
          createDirectories = true;
        }
        // (
          let
            hmdir = config.home.homeDirectory;
          in
          {
            # xdg default
            desktop = hmdir + "/Desktop";
            documents = hmdir + "/Documents";
            download = hmdir + "/Downloads";
            music = hmdir + "/Music";
            pictures = hmdir + "/Pictures";
            publicShare = hmdir + "/";
            templates = hmdir + "/";
            videos = hmdir + "/Videos";
          }
        );
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
