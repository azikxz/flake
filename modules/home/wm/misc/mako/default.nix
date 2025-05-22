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
            font = font.monospace.name;
            borderRadius = 8;
            borderSize = 2;
            backgroundColor = base01;
            borderColor = base0E;
            textColor = base06;
            layer = "overlay";
            sort = "+time";
            margin = "20, 20, 20";
            maxVisible = 5;
            defaultTimeout = 0;
          };
      };
  };
}
