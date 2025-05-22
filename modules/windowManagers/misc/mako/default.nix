{
  lib,
  config,
  ...
}:

with lib;

mkIf (itIs == "desktop" || itIs == "laptop") {
  hm.services.mako = with config.lib.stylix.colors.withHashtag; {
    enable = true;

    settings =
      let
        mk = a: b: c: {
          background-color = a;
          border-color = b;
          text-color = c;
        };
      in
      {
        "urgency=low" = mk base00 base0D base06;
        "urgency=high" = mk base00 base0C base06;
        "urgency=critical" = mk base00 base0A base06;

        icons = true;
        actions = false;
        anchor = "top-right";
        layer = "overlay";
        sort = "+time";
        margin = "20, 20, 20";

        borderRadius = 8;
        borderSize = 2;
        font = config.stylix.fonts.monospace.name;
        backgroundColor = base01;
        borderColor = base0E;
        textColor = base06;
        maxVisible = 5;
        defaultTimeout = 0;
      };
  };
}
