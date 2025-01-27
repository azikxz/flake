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
    mime.enable = mkBool;
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
          qt5ct = n "qt5ct";
          qt6ct = n "qt6ct";
          nvtop = n "nvtop";
          btop = n "btop";
          fish = n "fish";
          rofi = n "rofi";
          rofi-theme-selector = n "rofi-theme-selector";
        };
    };
  };
}
