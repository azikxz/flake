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
  cfg = config.module.wm.misc.flameshot;
in
{
  options = {
    module.wm.misc.flameshot = {
      enable = mkBool false;
    };
  };

  config = mkIf cfg.enable {
    services.flameshot = on // {
      package = pkgs.flameshot.override {
        enableWlrSupport = true;
        enableMonochromeIcon = true;
      };
      settings = with config.lib.stylix.colors.withHashtag; {
        General = {
          saveAsFileExtension = ".jpg";
          uiColor = "${base00}";
          contrastUiColor = "${base0E}";
          drawColor = "${base0C}";
          useJpgForClipboard = true;
        };
      };
    };
  };
}
