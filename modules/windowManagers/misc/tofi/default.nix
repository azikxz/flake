{
  lib,
  config,
  ...
}:

with lib;

mkIf (itIs == "desktop" || itIs == "laptop") {
  hm = with config.lib.stylix.colors.withHashtag; {
    programs.tofi = {
      enable = true;

      settings = {
        history = false;
        hide-cursor = true;
        text-cursor = true;

        font = config.stylix.fonts.monospace.name;

        width = "100%";
        height = "100%";

        border-width = 0;
        outline-width = 0;

        padding-left = "35%";
        padding-top = "20%";

        result-spacing = 25;
        num-results = 9;

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
      # conf
      ''
        history = false
        anchor = bottom
        width = 100%
        height = 40
        horizontal = true
        font-size = 18
        prompt-text = ""
        font = "${config.stylix.fonts.monospace.name}"
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
