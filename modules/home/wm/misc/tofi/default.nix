{
  lib,
  config,
  ...
}:

with lib;
with x;
let
  stylex = config.lib.stylix.colors.withHashtag;
  cfg = config.module.wm.misc.tofi;
  font = config.stylix.fonts;
in

{
  options = {
    module.wm.misc.tofi = {
      enable = mkBool false;
    };
  };

  config = mkIf cfg.enable {
    programs.tofi = on // {
      settings = with stylex; {
        history = false;
        hide-cursor = true;
        text-cursor = true;
        font = "${font.monospace.name}";
        width = "100%";
        height = "100%";
        border-width = 0;
        outline-width = 0;
        padding-left = "35%";
        padding-top = "20%";
        result-spacing = 25;
        num-results = 9;
        # colors
        background-color = base00;
        text-color = base05;
        prompt-color = base04;
        input-color = base04;
        selection-color = base0E;
        default-result-color = base03;
        selection-background = base01;
        selection-background-padding = 8;
        selection-background-corner-radius = 18;
      };
    };
    xdg.configFile."tofi/horizontal".text =
      with stylex;
      # conf
      ''
        history = false
        anchor = bottom
        width = 100%
        height = 40
        horizontal = true
        font-size = 18
        prompt-text = ""
        font = "${font.monospace.name}"
        outline-width = 0
        border-width = 0
        min-input-width = 0
        result-spacing = 15
        padding-top = 0
        padding-bottom = 0
        padding-left = 0
        padding-right = 0
        text-cursor = false

        selection-background-padding= 8
        background-color = "${base00}"
        text-color = "${base05}"
        prompt-color = "${base04}"
        input-color = "${base04}"
        selection-color = "${base0E}"
        default-result-color = "${base03}"
        selection-background = "${base01}"

        padding-top = 4
        padding-bottom = 4
      '';
  };
}
