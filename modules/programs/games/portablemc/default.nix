{
  pkgs,
  lib,
  ...
}:

with lib;
# INFO: launch minecraft via cli
# and mod manager in cli

mkIf false {
  persist.user.dirs = [
    ".config/ferium"
    ".minecraft"
  ];

  hmPackages = with pkgs; [
    ferium
    portablemc
  ];

  networking.firewall = genAttrs [
    "allowedTCPPorts"
    "allowedUDPPorts"
  ] (n: [ ]);

  nixpkgs.overlays = [
    (final: prev: {
      portablemc =
        with prev.lib;
        let
          jdks = [
            "24"
            "21"
            "17"
            "8"
          ];
        in
        prev.writeShellScriptBin "portablemc" ''
          set -euo pipefail

          ${concatLines (
            map (v: ''
              JRE_${v}="${getExe final."temurin-jre-bin-${v}"}"
            '') jdks
          )}

          JRE="$JRE_${head jdks}"

          case "''${1:-}" in
          ${concatLines (
            map (ver: ''
              --jre${ver})
                JRE="$JRE_${ver}"; shift ;;
            '') jdks
          )}
          esac

          exec ${
            getExe (
              prev.portablemc.override {
                jre = (final."temurin-jre-bin-${head jdks}");
              }
            )
          } --jvm "$JRE" "$@"
        '';
    })
  ];
}
