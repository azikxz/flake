{
  lib,
  ...
}:

with lib;
# INFO: server for manga reading
# with builtin webui

mkIf (mac "pcRyazenka") {
  services.suwayomi-server = {
    enable = true;

    openFirewall = true;
    settings.server = {
      port = 4567;

      extensionRepos = map (p: ("https://raw.githubusercontent.com/" + p)) [
        "suwayomi/tachiyomi-extension/repo/index.min.json"
        "yuzono/manga-repo/repo/index.min.json"
      ];
    };
  };

  nixpkgs.overlays = [
    (final: prev: {
      suwayomi-server = prev.suwayomi-server.override {
        jdk17_headless = final.temurin-jre-bin-17;
      };
    })
  ];
}
