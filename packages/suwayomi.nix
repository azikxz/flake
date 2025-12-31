{
  pkgs,
}:

# INFO:
# https://github.com/Suwayomi/Suwayomi-Server/pull/1813
# [Bartuzen] work for implement syncyomi
#
# https://github.com/azikxz/suwayomi/tree/syncyomi
# my forks o' fork for jar build

(pkgs.suwayomi-server.overrideAttrs {
  src = pkgs.fetchurl {
    url = "https://github.com/azikxz/suwayomi/releases/download/v1.0.0/Suwayomi-Server-v2.1.2069.jar";
    sha256 = "sha256-ZAOcW1Xtn5lZHp2gPXviJ/4DhYevv3n09TO5HA3g0q0=";
  };
}).override
  { jdk21_headless = pkgs.temurin-bin-21; }
