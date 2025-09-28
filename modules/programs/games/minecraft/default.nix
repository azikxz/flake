{
  pkgs,
  lib,
  config,
  ...
}:

with lib;
let
  imp = "gui";
in
# INFO: just play

mkIf (mac "pcRyazenka" || mac "thinkpadT14") {
  persist.user.dirs =
    if (imp == "cli") then
      [
        ".config/ferium"
        ".minecraft"
      ]
    else
      [ ".local/share/PrismLauncher" ];

  environment.systemPackages =
    with pkgs;
    if (imp == "cli") then
      [
        ferium
        portablemc
      ]
    else
      [ prismlauncher ];
  # INFO: moved to overlays

  networking.firewall =
    let
      main = 4445;
    in
    genAttrs [
      "allowedTCPPorts"
      "allowedUDPPorts"
    ] (n: [ main ]);

  hm.xdg.dataFile."PrismLauncher/prismlauncher.cfg".source =
    (pkgs.formats.ini { }).generate "prismlauncher-settings"
      (
        import ./settings.nix {
          inherit
            pkgs
            lib
            config
            ;
        }
      );

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
