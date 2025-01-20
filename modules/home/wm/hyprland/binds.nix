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
      m = mk "$m    , ";
      s = mk "$m  $s, ";
      a = mk "$m  $a, ";
      c = mk "$m  $c, ";
      fn = mk "     , ";
      fs = mk "   $s, ";
      fa = mk "   $a, ";
    in
    [
      # hjkl
      (m "H" "movefocus, l")
      (m "J" "movefocus, d")
      (m "K" "movefocus, u")
      (m "L" "movefocus, r")

      (s "H" "resizeactive, -50  0")
      (s "J" "resizeactive, 0   50")
      (s "K" "resizeactive, 0  -50")
      (s "L" "resizeactive, 50   0")

      (a "H" "swapwindow, l")
      (a "J" "swapwindow, d")
      (a "K" "swapwindow, u")
      (a "L" "swapwindow, r")

      (c "H" "moveactive, -50  0")
      (c "J" "moveactive, 0   50")
      (c "K" "moveactive, 0  -50")
      (c "L" "moveactive, 50   0")

      # arrows
      (m "left " "movefocus, l")
      (m "down " "movefocus, d")
      (m "up   " "movefocus, u")
      (m "right" "movefocus, r")

      (s "left " "resizeactive, -50  0")
      (s "down " "resizeactive, 0   50")
      (s "up   " "resizeactive, 0  -50")
      (s "right" "resizeactive, 50   0")

      (a "left " "swapwindow, l")
      (a "down " "swapwindow, d")
      (a "up   " "swapwindow, u")
      (a "right" "swapwindow, r")

      (c "left " "moveactive, -50  0")
      (c "down " "moveactive, 0   50")
      (c "up   " "moveactive, 0  -50")
      (c "right" "moveactive, 50   0")
    ]
    ++ [
      # sound
      (fn "XF86AudioMute       " "$ex, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle")
      (fn "XF86AudioMicMute    " "$ex, bash -c '${mic}'")
      (fn "XF86AudioRaiseVolume" "$ex, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+")
      (fn "XF86AudioLowerVolume" "$ex, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-")
      (fs "XF86AudioRaiseVolume" "$ex, wpctl set-volume @DEFAULT_AUDIO_SINK@ 10%+")
      (fs "XF86AudioLowerVolume" "$ex, wpctl set-volume @DEFAULT_AUDIO_SINK@ 10%-")
    ]
    ++ (with pkgs; [
      # light
      (fn "XF86MonBrightnessDown" "$ex, sudo ${light}/bin/light -U 10")
      (fn "XF86MonBrightnessUp  " "$ex, sudo ${light}/bin/light -A 10")
      (fs "XF86MonBrightnessDown" "$ex, sudo ${light}/bin/light -S 70")
      (fs "XF86MonBrightnessUp  " "$ex, sudo ${light}/bin/light -S 100")
    ])
    ++ [
      (fn "XF86Favorites" "$ex, wlogout -sc 12 -r 12")
      (fs "XF86Favorites" "$ex, poweroff")
      (fa "XF86Favorites" "$ex, reboot")
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
}
