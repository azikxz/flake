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
  cfg = config.module.programs.gui.swayimg;
  font = config.stylix.fonts;
in
{
  options = {
    module.programs.gui.swayimg = {
      enable = mkBool;
    };
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [ swayimg ];
    xdg.configFile = with config.lib.stylix.colors.withHashtag; {
      "swayimg/config".text = ''
        [general]
          mode = viewer
          position = parent
          size = fullscreen
          sigusr1 = reload
          sigusr2 = next_file
          app_id = swayimg

        [viewer]
          window = #000000ff
          transparency = grid
          scale = optimal
          fixed = yes
          antialiasing = no
          slideshow = no
          slideshow_time = 3
          history = 1
          preload = 1

        [gallery]
          size = 400
          cache = 100
          fill = yes
          antialiasing = yes
          window = ${base00}ff
          background = ${base01}ff
          select = ${base02}ff
          border = ${base0E}ff
          shadow = ${base00}a0

        [list]
          order = alpha
          loop = yes
          recursive = no
          all = yes

        [font]
          name = ${font.monospace.name}
          size = 14
          color = ${base06}ff
          shadow = ${base00}a0

        [info]
          show = yes
          info_timeout = 1
          status_timeout = 1

        [info.viewer]
          top_left = +name,+imagesize
          top_right = index
          bottom_left = status
          bottom_right = scale

        [info.gallery]
          top_left = none
          top_right = index
          bottom_left = none
          bottom_right = none

        [keys.viewer]
          # help
          F1 = help
          Space = mode
          Return = mode

          # mv
          t = exec mv "%" /persist/design/wallpapers; skip_file 
          
          # delete
          Delete = exec trash put "%"; skip_file # trash
          Shift+Delete = exec rm "%"; skip_file # delete
          
          # first/last image
          Home = first_file
          g = first_file
          End = last_file
          Shift+g = last_file

          # navigate
          Shift+Space = next_file
          Next = next_file
          Prior = prev_file
          # vi-keys
          j = next_file
          k = prev_file

          # zoom
          0 = zoom real
          Equal = zoom +10
          Plus = zoom +10
          Minus = zoom -10
          w = zoom width
          Shift+w = zoom height
          z = zoom fit
          Shift+z = zoom fill
          # vi-keys
          h = zoom +10
          l = zoom -10

          # fs

          # navigate in zoom
          Left = step_left 10
          Right = step_right 10
          Up = step_up 10
          Down = step_down 10

          # rotate
          bracketleft = rotate_left
          bracketright = rotate_right

          # flip
          m = flip_vertical
          Shift+m = flip_horizontal
          
          # other
          f = fullscreen
          a = antialiasing
          r = reload
          i = info
          q = exit
          Escape = exit
          
          # mouse
          Ctrl+ScrollUp = zoom +10
          Ctrl+ScrollDown = zoom -10
          Shift+ScrollUp = prev_file
          Shift+ScrollDown = next_file

        [keys.gallery]
          # help
          F1 = help
          Space = mode
          Return = mode

          # mv / copy
          t = exec mv "%" /persist/design/wallpapers; skip_file 

          # first/last image
          Home = first_file
          g = first_file
          End = last_file
          Shift+g = last_file

          # navigate
          Left = step_left
          Right = step_right
          Up = step_up
          Down = step_down
          # vi-keys
          h = step_left
          j = step_down
          k = step_up
          l = step_right

          # pages
          Prior = page_up
          Next = page_down
          
          # other
          f = fullscreen
          a = antialiasing
          r = reload
          i = info
          q = exit
          Escape = exit

          # delete
          Delete = exec trash put "%"; skip_file # trash
          Shift+Delete = exec rm "%"; skip_file # delete

          # mouse
          ScrollUp = page_up
          ScrollDown = page_down
      '';
    };
  };
}
