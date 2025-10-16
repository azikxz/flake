{
  lib,
  config,
  ...
}:

with lib;
# INFO: server for manga reading
# with builtin webui

mkIf (mac "pcRyazenka") {
  services.suwayomi-server = {
    enable = true;

    openFirewall = true;
    dataDir = config.hm.home.homeDirectory;

    settings.server = {
      port = 4567;

      extensionRepos = (
        map (p: ("https://raw.githubusercontent.com/" + p)) [
          "yuzono/manga-repo/repo/index.min.json"
        ]
      );

      updateMangas = true;
      downloadAsCbz = true;
    }
    // genAttrs [ "downloadsPath" "localSourcePath" ] (
      n: config.hm.xdg.userDirs.desktop + "/localManga"
    );
  }
  // genAttrs [ "user" "group" ] (n: system.userName);

  nixpkgs.overlays = [
    (final: prev: {
      suwayomi-server = prev.suwayomi-server.override {
        jdk17_headless = final.temurin-jre-bin-17;
      };
    })
  ];
}
