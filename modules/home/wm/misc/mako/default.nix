{
  lib,
  config,
  ...
}:

with lib;
with x;
let
  cfg = config.module.wm.misc.mako;
  font = config.stylix.fonts;
in

{
  options = {
    module.wm.misc.mako = {
      enable = mkBool false;
    };
  };

  config = mkIf cfg.enable {
    services.mako =
      with config.lib.stylix.colors.withHashtag;
      on
      // {
        icons = true;
        actions = false;
        anchor = "top-right";
        font = "${font.monospace.name}";
        # DECORATION
        borderRadius = 8;
        borderSize = 2;
        # COLORS
        backgroundColor = "${base01}";
        borderColor = "${base0E}";
        textColor = "${base06}";
        extraConfig = x.toGen "toINI" {
          "urgency=low" = {
            background-color = "${base00}";
            border-color = "${base0D}";
            text-color = "${base06}";
          };
          "urgency=high" = {
            background-color = "${base00}";
            border-color = "${base0C}";
            text-color = "${base06}";
          };
          "urgency=critical" = {
            background-color = "${base00}";
            border-color = "${base0A}";
            text-color = "${base06}";
          };
        };
        # SETTINGS
        layer = "overlay";
        sort = "+time";
        margin = "20, 20, 20";
        maxVisible = 5;
        defaultTimeout = 0;
      };
  };
}
