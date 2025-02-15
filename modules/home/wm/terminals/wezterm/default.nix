{
  lib,
  config,
  ...
}:

with lib;
with x;
let
  cfg = config.module.wm.terminals.wezterm;
in

{
  options = {
    module.wm.terminals.wezterm = {
      enable = mkBool false;
    };
  };

  config = mkIf cfg.enable {
    programs.wezterm = on // {
      extraConfig = # lua
        ''
          return {
            -- general
            audible_bell = "Disabled",
            check_for_updates = false,
            enable_scroll_bar = false,
            exit_behavior = "CloseOnCleanExit",
            warn_about_missing_glyphs =  false,

            -- anims
            animation_fps = 1,

            -- Cursor
            cursor_blink_ease_in = 'Constant',
            cursor_blink_ease_out = 'Constant',
            cursor_blink_rate = 700,
            default_cursor_style = "SteadyBar",

            keys = {
              -- paste from the clipboard
              { key = 'V', mods = 'SHIFT|CTRL', action = act.PasteFrom 'Clipboard' },

              -- paste from the primary selection
              { key = 'S', mods = 'SHIFT|CTRL', action = act.PasteFrom 'PrimarySelection' },
            },

            -- Tab bar
            enable_tab_bar = true,
            hide_tab_bar_if_only_one_tab = true,
            show_tab_index_in_tab_bar = false,
            tab_bar_at_bottom = true,
            use_fancy_tab_bar = false,
            -- try and let the tabs stretch instead of squish
            tab_max_width = 10000,

            -- perf
            enable_wayland = true,
            front_end = "WebGpu",
            scrollback_lines = 10000,

            -- term window settings
            adjust_window_size_when_changing_font_size = false,
            inactive_pane_hsb = {
              saturation = 1.0,
              brightness = 0.8
            },
            window_background_opacity = 0.85,
            window_close_confirmation = "NeverPrompt",
            window_decorations = "RESIZE",
            window_padding = { left = 12, right = 12, top = 12, bottom = 12, },
          }
        '';
    };
  };
}
