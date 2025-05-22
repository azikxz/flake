{
  pkgs,
  lib,
  ...
}:

with lib;
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
in

[
  # hjkl
  (m "h" "movefocus, l")
  (m "j" "movefocus, d")
  (m "k" "movefocus, u")
  (m "l" "movefocus, r")

  (s "h" "resizeactive, -50  0")
  (s "j" "resizeactive, 0   50")
  (s "k" "resizeactive, 0  -50")
  (s "l" "resizeactive, 50   0")

  (a "h" "swapwindow, l")
  (a "j" "swapwindow, d")
  (a "k" "swapwindow, u")
  (a "l" "swapwindow, r")

  (c "h" "moveactive, -50  0")
  (c "j" "moveactive, 0   50")
  (c "k" "moveactive, 0  -50")
  (c "l" "moveactive, 50   0")

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

  (fn "XF86AudioMute       " "$ex, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle")
  (fn "XF86AudioMicMute    " "$ex, ${getExe (
    pkgs.writeShellScriptBin "micMute" ''
      fixf4=$(cat /sys/class/leds/platform\:\:micmute/brightness);
      echo $((1-fixf4)) | sudo tee /sys/class/leds/platform\:\:micmute/brightness;
      wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle
    ''
  )}")

  (fn "XF86AudioRaiseVolume" "$ex, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+")
  (fn "XF86AudioLowerVolume" "$ex, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-")
  (fs "XF86AudioRaiseVolume" "$ex, wpctl set-volume @DEFAULT_AUDIO_SINK@ 10%+")
  (fs "XF86AudioLowerVolume" "$ex, wpctl set-volume @DEFAULT_AUDIO_SINK@ 10%-")

  (fn "XF86MonBrightnessDown" "$ex, sudo getExe light} -U 10")
  (fn "XF86MonBrightnessUp  " "$ex, sudo getExe light} -A 10")
  (fs "XF86MonBrightnessDown" "$ex, sudo getExe light} -S 70")
  (fs "XF86MonBrightnessUp  " "$ex, sudo getExe light} -S 100")

  (fn "XF86Favorites" "$ex, wlogout -sc 12 -r 12")
  (fs "XF86Favorites" "$ex, poweroff")

  (fn "XF86HangupPhone" "$ex, makoctl dismiss -a")
  (fs "XF86HangupPhone" "$ex, makoctl restore")
  (fs "XF86WLAN " "$ex, bluetoothctl connect 3C:B0:ED:3A:24:48")
]
