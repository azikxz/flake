{
  pkgs,
  lib,
  config,
  ...
}:

with lib;

mkIf (itIs == "desktop" || itIs == "laptop") {
  persist.user.dirs = [
    "Desktop"
    "Documents"
    "Downloads"
    "Music"
    "Pictures"
    "Study"
    "Sync"
    "Videos"
  ];

  environment.systemPackages = [ pkgs.xdg-user-dirs ];

  hm = {
    xdg = {
      enable = true;

      mime.enable = true;

      mimeApps =
        {
          enable = true;
        }
        // import ./mimeApps.nix {
          inherit
            lib
            ;
        };

      portal = {
        enable = true;

        config.common.default = [ "gtk" ];

        extraPortals = with pkgs; [
          xdg-desktop-portal-gtk
          xdg-desktop-portal-hyprland
        ];
      };

      userDirs =
        let
          mk = n: config.hm.home.homeDirectory + n;
        in
        {
          enable = true;
        }
        // rec {
          # xdg default
          desktop = mk "/Desktop";
          documents = mk "/Documents";
          download = mk "/Downloads";
          music = mk "/Music";
          pictures = mk "/Pictures";
          publicShare = mk "/";
          templates = mk "/";
          videos = mk "/Videos";

          createDirectories = true;

          extraConfig = {
            XDG_SCREENSHOTS_DIR = pictures + "/screenshots";
            XDG_FLAKE_DIR = paths.flakeDir;
            XDG_TORRENTS_DIR = config.services.qbittorrent.savePath;
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

    home.activation =
      let
        applications = "${config.hm.xdg.dataHome}/applications";
      in
      {
        rmDesktop = hm.dag.entryAfter [ "" ] ''
          run rm ${applications}/*.desktop && rm ${applications}/wine
        '';
      };
  };
}
