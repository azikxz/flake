{
  pkgs,
  lib,
  config,
  ...
}:

with lib;
# INFO:
# goon experience

mkIf (mac "pcRyazenka" || mac "thinkpadT14") {
  persist.user.dirs = [
    "Desktop"
    "Documents"
    "Downloads"
    "Music"
    "Pictures"
    "Videos"
  ];

  hm = {
    xdg = {
      enable = true;

      mime.enable = true;

      mimeApps = {
        enable = true;

        associations.added = config.hm.xdg.mimeApps.defaultApplications;
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
          videos = mk "/Videos";

          publicShare = null;
          templates = null;

          createDirectories = true;

          extraConfig = {
            SCREENSHOTS = pictures + "/screenshots";
            FLAKE = paths.flakeDir;
            TORRENTS = config.services.qbittorrent.serverConfig.BitTorrent.Session.DefaultSavePath;
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

      portal.enable = true;
    };

    gtk.gtk3.bookmarks =
      let
        mkDirs =
          subDir: mainDir:
          (concatStringsSep "/" [
            "file:/"
            subDir
            mainDir
          ]);
      in
      # home place
      (map (dir: (mkDirs config.hm.home.homeDirectory dir)) [
        "Documents"
        "Downloads"
        "Music"
        "Pictures"
        "Videos"
      ])
      ++
        # other fs place
        (map (dir: (mkDirs (toString null) dir)) [ paths.flakeDir ]);
  };
}
