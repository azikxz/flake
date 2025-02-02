{
  x,
  pkgs,
  lib,
  config,
  ...
}:
with lib;
with x;
let
  cfg = config.module.programs.gui.minecraft;
  jre = with pkgs; [
    temurin-jre-bin-23
    temurin-jre-bin # 21
    temurin-jre-bin-17
    temurin-jre-bin-8
  ];
in
{
  options = {
    module.programs.gui.minecraft = {
      enable = mkBool false;
    };
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      (prismlauncher.override {
        gamemodeSupport = true;
        controllerSupport = true;
        textToSpeechSupport = false;
        jdks = jre;
      })
      portablemc
      ferium
    ];
  };
}
