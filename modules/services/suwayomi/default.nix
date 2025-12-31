{
  pkgs,
  lib,
  config,
  ...
}:

with lib;
let
  inherit (config.services)
    syncyomi
    ;

  localDir = config.hm.xdg.userDirs.desktop + "/localManga";
in
# INFO:
# server for manga/manhwa reading
# with builtin webui

mkIf (mac "pcRyazenka" || mac "thinkpadT14") {
  persist.user.dirs = [ ".local/share/Tachidesk" ];

  services.suwayomi-server = {
    enable = true;

    # WARN:
    # idk why it is not works
    # https://github.com/Suwayomi/Suwayomi-Server/pull/1813
    #
    # package = pkgs.suwayomi;
    # suwayomi with syncyomi support

    dataDir = config.hm.home.homeDirectory;

    settings.server = {
      ip = "127.0.0.1";
      port = 4567;

      initialOpenInBrowserEnabled = false;

      globalUpdateInterval = 6.0;
      extensionRepos = (
        map (p: ("https://raw.githubusercontent.com/" + p)) [
          "yuzono/manga-repo/repo/index.min.json"
        ]
      );

      updateMangas = true;
      downloadAsCbz = true;
      downloadConversions = lib.listToAttrs (
        map
          (list: {
            name = list.from;
            value = {
              target = list.to;
              compressionLevel = 0.8;
            };
          })
          [
            {
              from = "image/webp";
              to = "image/jpeg";
            }
            {
              from = "image/png";
              to = "image/jpeg";
            }
          ]
      );

      backupPath = localDir + "backups";

      # syncYomiEnabled = true;
      # syncYomiHost = syncyomi.config.host;
      # syncYomiApiKey = "...";
      # syncInterval = 2;
    }
    //
      genAttrs
        [
          "downloadsPath"
          "localSourcePath"
        ]
        (
          n: localDir
          # unified genius
        );
  }
  // genAttrs [
    "user"
    "group"
  ] (n: system.userName);
  # INFO:
  # system user cause local dir

  nixpkgs.overlays = [
    (final: prev: {
      suwayomi-server = prev.suwayomi-server.override {
        jdk21_headless = final.temurin-jre-bin-21;
      };
    })
  ];
}
