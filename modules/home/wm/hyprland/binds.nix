{
  pkgs,
  lib,
  config,
  ...
}:

let
  inherit (lib)
    getExe
    x
    ;
  inherit (pkgs)
    uutils-coreutils-noprefix
    grilurp
    light
    ;
  cfg = config.module.wm.hyprland;
  tee = lib.getExe' uutils-coreutils-noprefix "tee";
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
      (m "SPACE" "togglefloating")
      (a "SPACE" "centerwindow")
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
      (mk "$m," "MOUSE_DOWN" "workspace, e+1")
      (mk "$m," "MOUSE_UP" "workspace, e-1")
      (mk "$m," "NEXT" "workspace, e+1")
      (mk "$m," "PRIOR" "workspace, e-1")
    ]
    ++ (
      let
        pic = "${config.xdg.userDirs.extraConfig.XDG_SCREENSHOTS_DIR}/$(date +'scr_%d-%m-%y_%H:%M:%S.png')";
      in
      [
        # screenshot
        (mk null null "PRINT, $ex, ${getExe grilurp} copysave area   " + pic)
        (mk null "$s" "PRINT, $ex, ${getExe grilurp} copysave output " + pic)
      ]
    )
    ++ cfg.binds
    ++ (builtins.concatLists (
      builtins.genList (
        i:
        let
          ws = i + 1;
        in
        [
          "$m,    code:1${toString i}, workspace,       ${toString ws}"
          "$m $s, code:1${toString i}, movetoworkspace, ${toString ws}"
        ]
      ) 10
    ));

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
      (m "LEFT " "movefocus, l")
      (m "DOWN " "movefocus, d")
      (m "UP   " "movefocus, u")
      (m "RIGHT" "movefocus, r")

      (s "LEFT " "resizeactive, -50  0")
      (s "DOWN " "resizeactive, 0   50")
      (s "UP   " "resizeactive, 0  -50")
      (s "RIGHT" "resizeactive, 50   0")

      (a "LEFT " "swapwindow, l")
      (a "DOWN " "swapwindow, d")
      (a "UP   " "swapwindow, u")
      (a "RIGHT" "swapwindow, r")

      (c "LEFT " "moveactive, -50  0")
      (c "DOWN " "moveactive, 0   50")
      (c "UP   " "moveactive, 0  -50")
      (c "RIGHT" "moveactive, 50   0")
    ]
    ++ (
      let
      in
      [
        (fn "XF86AudioMute       " "$ex, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle")
        (fn "XF86AudioMicMute    " "$ex, ${getExe (
          pkgs.writeShellScriptBin "micMute" ''
            fixf4=$(cat /sys/class/leds/platform\:\:micmute/brightness);
            echo $((1-fixf4)) | sudo ${tee} /sys/class/leds/platform\:\:micmute/brightness;
            wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle
          ''
        )}")
        (fn "XF86AudioRaiseVolume" "$ex, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+")
        (fn "XF86AudioLowerVolume" "$ex, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-")
        (fs "XF86AudioRaiseVolume" "$ex, wpctl set-volume @DEFAULT_AUDIO_SINK@ 10%+")
        (fs "XF86AudioLowerVolume" "$ex, wpctl set-volume @DEFAULT_AUDIO_SINK@ 10%-")
      ]
    )
    ++ [
      (fn "XF86MonBrightnessDown" "$ex, sudo ${getExe light} -U 10")
      (fn "XF86MonBrightnessUp  " "$ex, sudo ${getExe light} -A 10")
      (fs "XF86MonBrightnessDown" "$ex, sudo ${getExe light} -S 70")
      (fs "XF86MonBrightnessUp  " "$ex, sudo ${getExe light} -S 100")
    ]
    ++ [
      (fn "XF86Favorites" "$ex, wlogout -sc 12 -r 12")
      (fs "XF86Favorites" "$ex, poweroff")
      (fa "XF86Favorites" "$ex, reboot")
    ]
    ++ [
      (fn "XF86HangupPhone" "$ex, makoctl dismiss -a")
      (fs "XF86HangupPhone" "$ex, makoctl restore")
      (fs "XF86WLAN " "$ex, bluetoothctl connect 3C:B0:ED:3A:24:48")
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
