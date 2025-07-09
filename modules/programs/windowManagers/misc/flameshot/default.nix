{
  pkgs,
  lib,
  config,
  ...
}:

with lib;

mkIf false {
  hm.services.flameshot = {
    enable = false;

    package = pkgs.flameshot.override {
      enableWlrSupport = true;
      enableMonochromeIcon = true;
    };

    settings = with config.lib.stylix.colors.withHashtag; {
      General = {
        saveAsFileExtension = ".jpg";
        useJpgForClipboard = true;

        uiColor = base00;
        contrastUiColor = base0E;
        drawColor = base0C;
      };
    };
  };
}
