{
  pkgs,
  lib,
  config,
  ...
}:

with lib;

mkIf (mac "pcRyazenka" || mac "thinkpadT14") {
  persist.user.dirs = [
    "Desktop"
    "Documents"
    "Downloads"
    "Music"
    "Pictures"
    "Public"
    "Videos"
  ];

  hm = {
    xdg = {
      enable = true;

      mime.enable = true;

      mimeApps = {
        enable = true;
      }
      // import ./mimeApps.nix {
        inherit
          lib
          ;
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
          publicShare = mk "/Public";
          videos = mk "/Videos";

          createDirectories = true;

          extraConfig = {
            XDG_SCREENSHOTS_DIR = pictures + "/screenshots";
            XDG_FLAKE_DIR = paths.flakeDir;
            XDG_TORRENTS_DIR = config.services.qbittorrent.serverConfig.BitTorrent.Session.DefaultSavePath;
          };
        };

      desktopEntries =
        let
          mk = name: {
            inherit name;
            noDisplay = true;
          };
        in
        genAttrs [
          # qt
          "qt5ct"
          "qt6ct"

          # cli
          "nvtop"
          "btop"
          "fish"

          # shit
          "rofi"
          "rofi-theme-selector"

          # office
          "base"
          "calc"
          "draw"
          "impress"
          "math"
          "writer"
        ] (n: mk n);
    };
  };

  xdg = {
    terminal-exec = {
      enable = true;
      package = pkgs.xdg-terminal-exec-mkhl;

      settings = {
        default = [
          "kitty.desktop"
          "foot.desktop"
        ];
      };
    };

    portal = {
      enable = true;

      config.common.default = [ "gtk" ];

      extraPortals = with pkgs; [
        xdg-desktop-portal-gtk
        xdg-desktop-portal-hyprland
      ];
    };
  };
}
