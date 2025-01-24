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
  nD = name: {
    name = "${name}";
    noDisplay = true;
  };
in
{
  options.module.misc.xdg = {
    mime.enable = mkBool;
  };

  config = {
    home.packages = [ pkgs.xdg-user-dirs ];
    xdg = {
      mime = on;
      mimeApps = on // import ./mimeApps.nix { inherit x; };
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
      desktopEntries = {
        qt5ct = nD "qt5ct";
        qt6ct = nD "qt6ct";
        nvtop = nD "nvtop";
        btop = nD "btop";
        fish = nD "fish";
        rofi = nD "rofi";
        rofi-theme-selector = nD "rofi-theme-selector";
      };
    };
  };
}
