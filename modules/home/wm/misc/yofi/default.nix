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
  cfg = config.module.wm.misc.yofi;
  font = config.stylix.fonts;
  icon = config.gtk.iconTheme.name;
in
{
  options = {
    module.wm.misc.yofi = {
      enable = mkBool;
    };
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [ yofi ];
    xdg.configFile = with config.lib.stylix.colors; {
      "yofi/yofi.config".text = # toml
        ''
          width = 500
          height = 300
          force_window = false
          corner_radius = "32"
          font = "${font.monospace.name}"
          font_size = 24
          bg_color = 0x${base00}ff
          bg_border_color = 0x${base0E}ff
          bg_border_width = 4.0
          font_color = 0x${base0E}ff

          [input_text]
          font_color = 0x${base0F}ff
          bg_color = 0x${base01}ff
          margin = "8" # equivalent to "5 5 5 5"
          padding = "3 -4" # equivalent to "1.7 -4 1.7 -4"
          corner_radius = "12"

          [list_items]
          font_color = 0x${base0E}ff
          selected_font_color = 0x${base0D}ff
          match_color = 0x${base0A}ff
          margin = "10 60"
          hide_actions = true
          action_left_margin = 60
          item_spacing = 2
          icon_spacing = 5

          [icon]
          theme = "${icon}"
          size = 32
        '';
    };
  };
}
