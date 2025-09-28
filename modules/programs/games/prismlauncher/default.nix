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

  environment.systemPackages = [ pkgs.prismlauncher ];

  networking.firewall = genAttrs [
    "allowedTCPPorts"
    "allowedUDPPorts"
  ] (n: [ 25565 ]);

  hm.xdg.dataFile = {
    "PrismLauncher/prismlauncher.cfg".source = import ./settings.nix {
      inherit
        pkgs
        lib
        config
        ;
    };
  };

  nixpkgs.overlays = [
    (final: prev: {
      prismlauncher = prev.prismlauncher.override {
        gamemodeSupport = true;
        controllerSupport = true;
        textToSpeechSupport = false;

        jdks = attrValues {
          inherit (final)
            temurin-jre-bin-23
            temurin-jre-bin-21
            temurin-jre-bin-17
            temurin-jre-bin-8
            ;
        };
      };
    })
  ];
}
