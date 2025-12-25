{
  pkgs,
  lib,
  config,
  ...
}:

with config.hm.lib.niri.actions;

# modificators
let
  m = "Mod";
  s = "Shift";
  a = "Alt";
  c = "Ctrl";

  mk = name: action: {
    inherit
      name
      ;
    value = {
      inherit
        action
        ;
    };
  };

  sh = spawn-sh;
  msg = cmd: sh ("niri msg action " + cmd);
in

(lib.listToAttrs (
  # programs
  [
    (mk "${m}+Tab" (sh "bash -c tofi-drun | xargs niri msg action spawn --"))

    (mk "${m}+Return" (sh "kitty"))
    (mk "${m}+${s}+Return" (sh "kitty --class=kitty_small"))

    (mk "${m}+V" (sh "AyuGram"))
    (mk "${m}+${s}+V" (sh "equibop"))

    (mk "${m}+B" (sh "qutebrowser"))
    (mk "${m}+${s}+B" (sh "keepassxc"))

    (mk "${m}+M" (sh "spotify"))
    (mk "${m}+${s}+M" (sh "obsidian"))
  ]
  ++
    # main actions
    [
      (mk "${m}+${s}+Slash" show-hotkey-overlay) # help

      (mk "${m}+Q" close-window)

      (mk "${m}+Space" toggle-overview)
      (mk "${m}+${a}+Space" center-window)
      (mk "${m}+${s}+Space" (
        if config.hm.programs.wleave.enable then
          (sh (lib.getExe config.hm.programs.wleave.package))
        else
          quit
      ))

      (mk "${m}+F" fullscreen-window)
      (mk "${m}+${s}+F" maximize-column)

      # (mk "Print" (spawn "niri" "msg" "action" "screenshot-screen"))
      # (mk "${s}+Print" screenshot-window)
      # https://github.com/sodiboo/niri-flake/issues/1380
      # fuck it, i w'ont to fuck with this

      (mk "${m}+S" switch-preset-column-width)
      (mk "${m}+${s}+S" switch-preset-window-height)

      (mk "${m}+Minus" (set-column-width "-10%"))
      (mk "${m}+Equal" (set-column-width "+10%"))
      (mk "${m}+${s}+Minus" (set-window-height "-10%"))
      (mk "${m}+${s}+Equal" (set-window-height "+10%"))

      (mk "${m}+Comma" consume-window-into-column)
      (mk "${m}+Period" expel-window-from-column)
    ]
  # windows manipukating
  ++ [
    (mk "${m}+H" focus-column-left)
    (mk "${m}+J" focus-window-or-workspace-down)
    (mk "${m}+K" focus-window-or-workspace-up)
    (mk "${m}+L" focus-column-right)

    (mk "${m}+Left" focus-column-left)
    (mk "${m}+Down" focus-window-or-workspace-down)
    (mk "${m}+Up" focus-window-or-workspace-up)
    (mk "${m}+Right" focus-column-right)

    (mk "${m}+${s}+H" move-column-left)
    (mk "${m}+${s}+J" move-column-to-workspace-down)
    (mk "${m}+${s}+K" move-column-to-workspace-up)
    (mk "${m}+${s}+L" move-column-right)

    (mk "${m}+${s}+Left" move-column-left)
    (mk "${m}+${s}+Down" move-column-to-workspace-down)
    (mk "${m}+${s}+Up" move-column-to-workspace-up)
    (mk "${m}+${s}+Right" move-column-right)

    (mk "${m}+${c}+J" move-window-down-or-to-workspace-down)
    (mk "${m}+${c}+K" move-window-up-or-to-workspace-up)

    (mk "${m}+${c}+Down" move-window-down-or-to-workspace-down)
    (mk "${m}+${c}+Up" move-window-up-or-to-workspace-up)
  ]
  # screenshots
  ++ [
    (mk "Print" (msg "screenshot -p false"))
    (mk "${s}+Print" (msg "screenshot-screen -p false"))
    (mk "${a}+Print" (msg "screenshot-window -p false"))
  ]
  # volume and brightness
  ++ (
    let
      inherit (config.hm.home.sessionVariables)
        WOBSOCK_PATH
        ;

      mute = " && wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{if ($3) print 0; else print int($2*100)}' > ${WOBSOCK_PATH}";
      vol = " && wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{print int($2*100)}' > ${WOBSOCK_PATH}";
      light = " && sudo ${lib.getExe pkgs.light} -G | cut -d'.' -f1 > ${WOBSOCK_PATH}";

      make = volume: audio: brightness: [
        (mk "XF86AudioMute" (sh ("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle" + audio)))
        (mk "XF86AudioMicMute" (sh "wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"))

        (mk "XF86AudioRaiseVolume" (sh ("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+" + volume)))
        (mk "XF86AudioLowerVolume" (sh ("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%-" + volume)))
        (mk "${s}+XF86AudioRaiseVolume" (sh ("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 10%+" + volume)))
        (mk "${s}+XF86AudioLowerVolume" (sh ("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 10%-" + volume)))

        (mk "${m}+TouchpadScrollUp" (sh ("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+" + volume)))
        (mk "${m}+TouchpadScrollDown" (sh ("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%-" + volume)))

        (mk "XF86MonBrightnessUp" (sh ("sudo ${lib.getExe pkgs.light} -A 10" + brightness)))
        (mk "XF86MonBrightnessDown" (sh ("sudo ${lib.getExe pkgs.light} -U 10" + brightness)))
        (mk "${s}+XF86MonBrightnessUp" (sh ("sudo ${lib.getExe pkgs.light} -S 70" + brightness)))
        (mk "${s}+XF86MonBrightnessDown" (sh ("sudo ${lib.getExe pkgs.light} -S 100" + brightness)))

        (mk "${m}+TouchpadScrollRight" (sh ("sudo ${lib.getExe pkgs.light} -A 10" + brightness)))
        (mk "${m}+TouchpadScrollDown" (sh ("sudo ${lib.getExe pkgs.light} -U 10" + brightness)))

        (mk "XF86Favorites" (spawn "wleave"))
      ];
    in
    if (config.hm.services.wob.enable) then
      (make vol mute light)
    else
      (make (toString null) (toString null) (toString null))
  )
))
# workspaces switch
// {
  "${m}+WheelScrollDown" = {
    cooldown-ms = 150;
    action = focus-workspace-down;
  };

  "${m}+WheelScrollUp" = {
    cooldown-ms = 150;
    action = focus-workspace-up;
  };

  "${m}+1".action = focus-workspace 1;
  "${m}+2".action = focus-workspace 2;
  "${m}+3".action = focus-workspace 3;
  "${m}+4".action = focus-workspace 4;
  "${m}+5".action = focus-workspace 5;
  "${m}+6".action = focus-workspace 6;
  "${m}+7".action = focus-workspace 7;
  "${m}+8".action = focus-workspace 8;
  "${m}+9".action = focus-workspace 9;
  "${m}+0".action = focus-workspace 10;

  "${m}+${s}+1".action = msg "move-column-to-workspace 1";
  "${m}+${s}+2".action = msg "move-column-to-workspace 2";
  "${m}+${s}+3".action = msg "move-column-to-workspace 3";
  "${m}+${s}+4".action = msg "move-column-to-workspace 4";
  "${m}+${s}+5".action = msg "move-column-to-workspace 5";
  "${m}+${s}+6".action = msg "move-column-to-workspace 6";
  "${m}+${s}+7".action = msg "move-column-to-workspace 7";
  "${m}+${s}+8".action = msg "move-column-to-workspace 8";
  "${m}+${s}+9".action = msg "move-column-to-workspace 9";
  "${m}+${s}+0".action = msg "move-column-to-workspace 10";
}
