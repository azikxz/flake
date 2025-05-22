{
  pkgs,
  lib,
  ...
}:

with lib;

mkIf (itIs == "desktop" || itIs == "laptop") {
  persist.user.dirs = [
    ".local/share/PrismLauncher"
    ".config/ferium"
    ".minecraft"
  ];

  hm.home.packages = with pkgs; [
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
}
