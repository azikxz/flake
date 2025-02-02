{
  x,
  pkgs,
  lib,
  config,
  ...
}:
with lib;
with x;
let
  hmdir = config.home.homeDirectory;
in
{
  options.module.misc.xdg = {
    mime.enable = mkBool false;
  };

  config = {
    home.packages = [ pkgs.xdg-user-dirs ];
    xdg = {
      mime = on;
      mimeApps = on // import ./mimeApps.nix;
      portal = on // {
        config.common.default = "gtk";
        extraPortals = with pkgs; [
          xdg-desktop-portal-gtk
          xdg-desktop-portal-hyprland
        ];
      };
      userDirs = on // {
        createDirectories = true;
        # xdg default
        desktop = "${hmdir}/Desktop";
        documents = "${hmdir}/Documents";
        download = "${hmdir}/Downloads";
        music = "${hmdir}/Music";
        pictures = "${hmdir}/Pictures";
        publicShare = "${hmdir}/";
        templates = "${hmdir}/";
        videos = "${hmdir}/Videos";
      };
      desktopEntries =
        let
          n = name: {
            name = "${name}";
            noDisplay = true;
          };
        in
        {
          # qt
          qt5ct = n "qt5ct";
          qt6ct = n "qt6ct";
          # cli
          nvtop = n "nvtop";
          btop = n "btop";
          fish = n "fish";
          # shit
          rofi = n "rofi";
          rofi-theme-selector = n "rofi-theme-selector";
          # office
          base = n "base";
          calc = n "calc";
          draw = n "draw";
          impress = n "impress";
          math = n "math";
          writer = n "writer";
        };
    };
  };
}
