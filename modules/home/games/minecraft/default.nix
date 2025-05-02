{
  pkgs,
  lib,
  config,
  ...
}:

with lib;
with x;
let
  cfg = config.module.games.minecraft;
in

{
  options = {
    module.games.minecraft = {
      enable = mkBool false;
      cli.enable = mkBool false;
    };
  };

  config = mkIf cfg.enable {
    impermanence.dirs = [ ".local/share/PrismLauncher" ];
    home.packages =
      with pkgs;
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
      ]
      ++ (optional cfg.cli.enable [
        portablemc
        ferium
      ]);
  };
}
