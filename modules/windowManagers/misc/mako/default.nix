{
  lib,
  config,
  ...
}:

with lib;

mkIf (machine == "pcRyazenka" || machine == "thinkpadT14") {
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

        border-radius = 8;
        border-size = 2;
        font = config.stylix.fonts.monospace.name;
        background-color = base01;
        border-color = base0E;
        text-color = base06;
        max-visible = 5;
        default-timeout = 0;
      };
  };
}
