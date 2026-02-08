{
  pkgs,
  lib,
  ...
}:

with lib;
# INFO:
# factory maker
# and tower defense, very cool

mkIf (mac "pcRyazenka" || mac "thinkpadT14") {
  persist.user.dirs = [ ".local/share/Mindustry" ];

  hmPackages = [ pkgs.mindustry ];

  hm.xdg.dataFile =
    (
      mods:
      listToAttrs (
        map (
          mod:
          let
            modName = removeSuffix ".jar" (baseNameOf mod.url) + ".zip";
          in
          {
            name = "Mindustry/mods/${modName}";
            value.source = pkgs.runCommand modName { } ''
              cp ${
                pkgs.fetchurl {
                  inherit (mod)
                    url
                    sha256
                    ;
                }
              } $out
            '';
          }
        ) mods
      )
    )
      # example...
      # {
      #   url = "...";
      #   sha256 = "..."; # nix store prefetch-file url
      # }
      [
        (
          let
            ver = "2.3.3";
          in
          {
            url = "https://github.com/xpdustry/claj/releases/download/${ver}/claj-client.jar";
            sha256 = "sha256-WDzzfv4Bh9l6cMcf8QVNFETK+qX74PPN5AdbNWtcvRE=";
          }
        )
      ];

  nixpkgs.overlays = [
    (final: prev: {
      mindustry = prev.mindustry.override {
        jdk17 = final.temurin-jre-bin-17;
      };
    })
  ];
}
