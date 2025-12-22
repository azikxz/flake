{
  pkgs,
  lib,
  config,
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

  (a "h" "moveactive, -50  0")
  (a "j" "moveactive, 0   50")
  (a "k" "moveactive, 0  -50")
  (a "l" "moveactive, 50   0")

  (c "h" "swapwindow, l")
  (c "j" "swapwindow, d")
  (c "k" "swapwindow, u")
  (c "l" "swapwindow, r")

  # arrows
  (m "left " "movefocus, l")
  (m "down " "movefocus, d")
  (m "up   " "movefocus, u")
  (m "right" "movefocus, r")

  (s "left " "resizeactive, -50  0")
  (s "down " "resizeactive, 0   50")
  (s "up   " "resizeactive, 0  -50")
  (s "right" "resizeactive, 50   0")

  (a "left " "moveactive, -50  0")
  (a "down " "moveactive, 0   50")
  (a "up   " "moveactive, 0  -50")
  (a "right" "moveactive, 50   0")

  (c "left " "swapwindow, l")
  (c "down " "swapwindow, d")
  (c "up   " "swapwindow, u")
  (c "right" "swapwindow, r")

  (fn "XF86AudioMute" "$ex, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle")

  (fn "XF86AudioMicMute" "$ex, ${getExe (
    pkgs.writeShellScriptBin "micMute" ''
      fixf4=$(cat /sys/class/leds/platform\:\:micmute/brightness);
      echo $((1-fixf4)) | sudo ${getExe' pkgs.coreutils "tee"} /sys/class/leds/platform\:\:micmute/brightness;
      wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle
    ''
  )}")

  (fn "XF86Favorites" "$ex, wleave")
  (fs "XF86Favorites" "$ex, hyprctl dispatch dpms toggle")

  (fn "XF86HangupPhone" "$ex, makoctl dismiss -a")
  (fs "XF86HangupPhone" "$ex, makoctl restore")

  (fn "XF86AudioRaiseVolume" "$ex, wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+")
  (fn "XF86AudioLowerVolume" "$ex, wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%-")
  (fs "XF86AudioRaiseVolume" "$ex, wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 10%+")
  (fs "XF86AudioLowerVolume" "$ex, wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 10%-")
]
++ (optionals config.hm.services.wob.enable [
  (fn "XF86AudioRaiseVolume" "$ex, wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{print int($2*100)}' > $WOBSOCK")
  (fn "XF86AudioLowerVolume" "$ex, wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{print int($2*100)}' > $WOBSOCK")
  (fs "XF86AudioRaiseVolume" "$ex, wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{print int($2*100)}' > $WOBSOCK")
  (fs "XF86AudioLowerVolume" "$ex, wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{print int($2*100)}' > $WOBSOCK")

  (fn "XF86AudioMute" "$ex, wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{if ($3) print int($2*100); else print 0}' > $WOBSOCK")
])
++ (
  let
    make = arg: [
      (fn "XF86MonBrightnessDown" ("$ex, sudo ${getExe pkgs.light} -U 10" + arg))
      (fn "XF86MonBrightnessUp  " ("$ex, sudo ${getExe pkgs.light} -A 10" + arg))
      (fs "XF86MonBrightnessDown" ("$ex, sudo ${getExe pkgs.light} -S 70" + arg))
      (fs "XF86MonBrightnessUp  " ("$ex, sudo ${getExe pkgs.light} -S 100" + arg))
    ];
  in
  if config.hm.services.wob.enable then
    (make " && sudo ${getExe pkgs.light} -G | cut -d'.' -f1 > $WOBSOCK")
  else
    (make (toString null))
)
