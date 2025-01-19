{
  x,
  lib,
  config,
  ...
}:
with lib;
with x;
let
  cfg = config.module.wm.misc.wob;
in
{
  options = {
    module.wm.misc.wob = {
      enable = mkBool;
    };
  };

  config = mkIf cfg.enable {
    services.wob =
      with config.lib.stylix.colors;
      on
      // {
        systemd = true;
        settings = {
          "" = {
            background_color = "${base00}";
            bar_color = "${base03}";
            border_color = "${base0E}";
            anchor = "top right";

            overflow_background_color = "${base00}";
            overflow_bar_color = "${base03}";
            overflow_border_color = "${base0C}";

            margin = 30;
            height = 50;
            width = 400;
            border_size = 10;
            bar_padding = 6;
            output_mode = "focused";
          };
        };
      };
  };
}
