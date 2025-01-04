{
  lib,
  config,
  ...
}:
with lib;
let
  cfg = config.module.wm.hyprland;
  mic = "fixf4=$(cat /sys/class/leds/platform::micmute/brightness); echo $((1-fixf4)) | doas tee /sys/class/leds/platform::micmute/brightness; wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle";
  workspaces =
    with builtins;
    (concatLists (
      genList (
        i:
        let
          ws = i + 1;
        in
        [
          "$mod, code:1${toString i}, workspace, ${toString ws}"
          "$mod SHIFT, code:1${toString i}, movetoworkspace, ${toString ws}"
        ]
      ) 10
    ));
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

    # binds
    bind =
      [
        "$m, $sp, togglefloating"
        "$m, Q,   killactive"

        "$m,     F, fullscreen"
        "$m  $s, F, centerwindow"

        "$m,     X, pseudo"
        "$m  $s, X, pin"
        # window control
        "$m,     W, cyclenext"
        "$m  $s, W, swapnext"

        "$m,     C, changegroupactive"
        "$m,     G, togglegroup"
        "$m  $s, G, moveoutofgroup"
        # window movement
        "$m,     A, togglespecialworkspace,  extra"
        "$m  $s, A, movetoworkspace, special:extra"

        "$m,     D, togglespecialworkspace,  magic"
        "$m  $s, D, movetoworkspace, special:magic"
        # special workspaces
        "$m, $md, workspace, e+1"
        "$m, $mu, workspace, e-1"

        "$m, $nx, workspace, e+1"
        "$m, $pr, workspace, e-1"
      ] # chsnge workspaces via mouse wheel
      ++ workspaces
      ++ cfg.binds;

    # HOLDING BUTTONS
    binde =
      let
        mf = "movefocus";
        sw = "swapwindow";
        ra = "resizeactive";
        ma = "moveactive";
      in
      [
        # hjkl
        "$m, H,    ${mf}, l"
        "$m, J,    ${mf}, d"
        "$m, K,    ${mf}, u"
        "$m, L,    ${mf}, r"

        "$m $s, H, ${sw}, l"
        "$m $s, J, ${sw}, d"
        "$m $s, K, ${sw}, u"
        "$m $s, L, ${sw}, r"

        "$m $a, H, ${ra}, -50 0"
        "$m $a, J, ${ra}, 0 50"
        "$m $a, K, ${ra}, 0 -50"
        "$m $a, L, ${ra}, 50 0"

        "$m $c, H, ${ma}, -50 0"
        "$m $c, J, ${ma}, 0 50"
        "$m $c, K, ${ma}, 0 -50"
        "$m $c, L, ${ma}, 50 0"

        # arrows
        "$m, left,     ${mf}, l"
        "$m, down,     ${mf}, d"
        "$m, up,       ${mf}, u"
        "$m, right,    ${mf}, r"

        "$m $s, left,  ${sw}, l"
        "$m $s, down,  ${sw}, d"
        "$m $s, up,    ${sw}, u"
        "$m $s, right, ${sw}, r"

        "$m $a, left,  ${ra}, -50 0"
        "$m $a, down,  ${ra}, 0  50"
        "$m $a, up,    ${ra}, 0 -50"
        "$m $a, right, ${ra}, 50  0"

        "$m $c, left,  ${ma}, -50 0"
        "$m $c, down,  ${ma}, 0  50"
        "$m $c, up,    ${ma}, 0 -50"
        "$m $c, right, ${ma}, 50  0"
      ]
      ++ [
        # sound
        ", XF86AudioMute,        $ex, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
        ", XF86AudioMicMute,     $ex, ${mic}"
        ", XF86AudioRaiseVolume, $ex, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"
        ", XF86AudioLowerVolume, $ex, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
      ]
      ++ [
        # light
        ", XF86MonBrightnessDown, $ex, sudo light -U 10"
        ", XF86MonBrightnessUp,   $ex, sudo light -A 10"
      ];
    bindm = [
      # mouse
      "$m,     mouse:272, movewindow"
      "$m,     mouse:273, resizewindow"
      "$m  $s, mouse:273, resizewindow 1"
    ];
  };
}
