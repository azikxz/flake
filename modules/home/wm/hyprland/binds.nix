{
  x,
  pkgs,
  lib,
  config,
  ...
}:
with lib;
let
  cfg = config.module.wm.hyprland;
  tee = "${pkgs.uutils-coreutils-noprefix}/bin/tee";
  mic = ''fixf4=$(cat /sys/class/leds/platform\:\:micmute/brightness); echo $((1-fixf4)) | sudo ${tee} /sys/class/leds/platform\:\:micmute/brightness; wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle'';
in
{
  wayland.windowManager.hyprland.settings = {
    # shortcuts
    "$m" = "SUPER";
    "$s" = "SHIFT";
    "$a" = "ALT";
    "$c" = "CTRL";

    "$rt" = "RETURN";
    "$sp" = "SPACE";
    "$tb" = "TAB";

    "$nx" = "Next";
    "$pr" = "Prior";
    "$PR" = "Print";

    "$md" = "mouse_down";
    "$mu" = "mouse_up";
    "$ex" = "exec";

    "$Mf" = "movefocus";
    "$Sw" = "swapwindow";
    "$Ra" = "resizeactive";
    "$Ma" = "moveactive";
    # binds
    bind =
      let
        mk =
          mod: args: cmd:
          "${toString mod} ${toString args}, ${toString cmd}";
        m = mk "$m,     ";
        s = mk "$m  $s, ";
        a = mk "$m  $a, ";
      in
      [
        (m "$sp" "togglefloating")
        (a "$sp" "centerwindow")
        # window control
        (m "Q" "killactive")
        (m "F" "fullscreen")

        (m "X" "pseudo")
        (s "X" "pin")

        (m "W" "cyclenext")
        (s "W" "swapnext")

        # window movement
        (m "C" "changegroupactive")
        (m "G" "togglegroup")
        (s "G" "moveoutofgroup")

        # special workspaces
        (m "A" "togglespecialworkspace,  extra")
        (s "A" "movetoworkspace, special:extra")
        (m "D" "togglespecialworkspace,  magic")
        (s "D" "movetoworkspace, special:magic")

        # chsnge workspaces via mouse wheel
        (mk "$m," "$md" "workspace, e+1")
        (mk "$m," "$mu" "workspace, e-1")
        (mk "$m," "$nx" "workspace, e+1")
        (mk "$m," "$pr" "workspace, e-1")
      ] # modules
      ++ cfg.binds
      ++ x.workspaces;

    # HOLDING BUTTONS
    binde =
      let
        mk =
          mod: args: cmd:
          "${toString mod} ${toString args}, ${toString cmd}";
        m = mk "$m,     ";
        s = mk "$m  $s, ";
        a = mk "$m  $a, ";
        c = mk "$m  $c, ";
        fn = mk ",";
      in
      [
        # hjkl
        (m "H" "$Mf, l")
        (m "J" "$Mf, d")
        (m "K" "$Mf, u")
        (m "L" "$Mf, r")

        (s "H" "$Sw, l")
        (s "J" "$Sw, d")
        (s "K" "$Sw, u")
        (s "L" "$Sw, r")

        (a "H" "$Ra, -50  0")
        (a "J" "$Ra, 0   50")
        (a "K" "$Ra, 0  -50")
        (a "L" "$Ra, 50   0")

        (c "H" "$Ma, -50  0")
        (c "J" "$Ma, 0   50")
        (c "K" "$Ma, 0  -50")
        (c "L" "$Ma, 50   0")

        # arrows
        (m "left " "$Mf, l")
        (m "down " "$Mf, d")
        (m "up   " "$Mf, u")
        (m "right" "$Mf, r")

        (s "left " "$Sw, l")
        (s "down " "$Sw, d")
        (s "up   " "$Sw, u")
        (s "right" "$Sw, r")

        (a "left " "$Ra, -50  0")
        (a "down " "$Ra, 0   50")
        (a "up   " "$Ra, 0  -50")
        (a "right" "$Ra, 50   0")

        (c "left " "$Ma, -50  0")
        (c "down " "$Ma, 0   50")
        (c "up   " "$Ma, 0  -50")
        (c "right" "$Ma, 50   0")
      ]
      ++ [
        # sound
        (fn "XF86AudioMute       " "$ex, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle")
        (fn "XF86AudioMicMute    " "$ex, bash -c '${mic}'")
        (fn "XF86AudioRaiseVolume" "$ex, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+")
        (fn "XF86AudioLowerVolume" "$ex, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-")
      ]
      ++ (with pkgs; [
        # light
        (fn "XF86MonBrightnessDown" "$ex, sudo ${light}/bin/light -U 10")
        (fn "XF86MonBrightnessUp  " "$ex, sudo ${light}/bin/light -A 10")
      ])
      ++ [
        (fn "XF86Favorites" "$ex, wlogout -sc 12 -r 12")
      ];
    bindm =
      let
        mk =
          mod: args: cmd:
          "${toString mod} ${toString args}, ${cmd}";
        m = mk "$m,   ";
        s = mk "$m $s,";
      in
      [
        # mouse
        (m "mouse:272" "movewindow")
        (m "mouse:273" "resizewindow")
        (s "mouse:273" "resizewindow 1")
      ];
  };
}
