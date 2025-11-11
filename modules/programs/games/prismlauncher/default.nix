{
  pkgs,
  lib,
  config,
  ...
}:

with lib;
# INFO: just play

mkIf (mac "pcRyazenka" || mac "thinkpadT14") {
  persist.user.dirs = [ ".local/share/PrismLauncher" ];

  hmPackages = [ pkgs.prismlauncher ];

  networking.firewall = genAttrs [
    "allowedTCPPorts"
    "allowedUDPPorts"
  ] (n: [ 25565 ]);

  hm.xdg.dataFile = {
    "PrismLauncher/prismlauncher.cfg".source = (
      import ./settings.nix {
        inherit
          pkgs
          lib
          config
          ;
      }
    );
  };

  hmMime = mkMime {
    "org.prismlauncher.PrismLauncher.desktop" = [
      "x-scheme-handler/prismlauncher"
      "x-scheme-handler/curseforge"
      "application/x-modrinth-modpack+zip"
      "application/zip"
    ];
  };

  nixpkgs.overlays = [
    (final: prev: {
      prismlauncher = prev.prismlauncher.override {
        gamemodeSupport = true;
        controllerSupport = true;
        textToSpeechSupport = false;

        jdks = attrValues {
          inherit (final)
            # its all LTS
            # https://adoptium.net/temurin/releases
            temurin-jre-bin-25
            temurin-jre-bin-21
            temurin-jre-bin-17
            temurin-jre-bin-8
            ;
        };
      };
    })
  ];
}
