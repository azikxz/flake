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

mkIf (itIs == "desktop" || itIs == "laptop") {
  persist.user.dirs =
    if (imp == "cli") then
      [
        ".config/ferium"
        ".minecraft"
      ]
    else
      [
        ".local/share/PrismLauncher"
      ];

  environment.systemPackages =
    with pkgs;
    if (imp == "cli") then
      [
        ferium
        portablemc
      ]
    else
      [
        (prismlauncher.override {
          gamemodeSupport = true;
          controllerSupport = true;
          textToSpeechSupport = false;

          jdks = builtins.attrValues {
            inherit
              temurin-jre-bin-23
              temurin-jre-bin # 21
              temurin-jre-bin-17
              temurin-jre-bin-8
              ;
          };
        })
      ];

  networking.firewall =
    let
      main = 4445;
    in
    {
      allowedTCPPorts = [ main ];
      allowedUDPPorts = [ main ];
    };

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
}
