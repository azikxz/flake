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
  cfg = config.module.shells.fish;
  ani = config.module.programs.custom.anicli;
  abbrs = config.module.shells.abbrs;
in
{
  options = {
    module.shells.fish = {
      enable = mkBool;
    };
  };

  config = mkIf cfg.enable {
    programs.fish = True // {
      package = pkgs.fish;
      preferAbbrs = true;
      shellAbbrs = abbrs;
      interactiveShellInit = ''
        set fish_greeting
      '';
      shellInitLast = # fish
        ''
          set fish_cursor_default block
          set fish_cursor_insert line
          set fish_cursor_replace_one underscore
          set fish_cursor_replace underscore
          set fish_cursor_visual block
          set fish_cursor_external line

          set -g tide_prompt_transient_enabled true
          set -g tide_prompt_add_newline_before true
          set -g tide_left_prompt_items pwd git newline character
          set -g tide_right_prompt_items cmd_duration
          set -g tide_cmd_duration_icon 
          set -g tide_cmd_duration_threshold 1000
          set -g tide_pwd_icon_home "home of user ${userName}"
          set -g tide_pwd_icon 󰋜

          set -g tide_pwd_icon_unwritable 󰌾
          set -g tide_pwd_transient_enabled true
          set -g tide_pwd_color_truncated_dirs brblack
          set -g tide_pwd_color_dirs blue
          set -g tide_pwd_color_anchors blue
          set -g tide_git_color_branch -o green

          [ "$(tty)" = "/dev/tty1" ] && exec Hyprland # LAUNCH WM
        '';
      functions = mkIf ani.enable {
        aniD = "anicli-ru --search $argv -s dreamcast";
        aniG = "anicli-ru --search $argv -s animego";
      };
    };
  };
}
