{
  config,
  ...
}:

with config.hm.lib.niri.actions;

let
  m = "Mod";
  s = "Shift";
  a = "Alt";
  c = "Ctrl";

  mk = name: action: {
    inherit name;
    value = { inherit action; };
  };
in

(builtins.listToAttrs (
  [
    (mk "${m}+Backslash" show-hotkey-overlay) # help

    (mk "${m}+Q" close-window)
    (mk "${m}+Grave" quit)

    (mk "${m}+Space" toggle-window-floating)
    (mk "${m}+${s}+Space" toggle-overview)
    (mk "${m}+${a}+Space" center-window)

    (mk "${m}+F" maximize-column)
    (mk "${m}+${s}+F" fullscreen-window)

    (mk "Print" (spawn "niri" "msg" "action" "screenshot-screen"))
    (mk "${s}+Print" screenshot-window)

    (mk "${m}+S" switch-preset-column-width)
    (mk "${m}+Comma" consume-window-into-column)
    (mk "${m}+Period" expel-window-from-column)

    (mk "${m}+Minus" (set-column-width "-10%"))
    (mk "${m}+Equal" (set-column-width "+10%"))
    (mk "${m}+${s}+Minus" (set-window-height "-10%"))
    (mk "${m}+${s}+Equal" (set-window-height "+10%"))
  ]
  ++ [
    (mk "${m}+H" focus-column-left)
    (mk "${m}+J" focus-window-or-workspace-down)
    (mk "${m}+K" focus-window-or-workspace-up)
    (mk "${m}+L" focus-column-right)

    (mk "${m}+Left" focus-column-left)
    (mk "${m}+Down" focus-window-or-workspace-down)
    (mk "${m}+Up" focus-window-or-workspace-up)
    (mk "${m}+Right" focus-column-right)
  ]
  ++ [
    (mk "${m}+${s}+H" move-column-left)
    (mk "${m}+${s}+J" move-column-to-workspace-down)
    (mk "${m}+${s}+K" move-column-to-workspace-up)
    (mk "${m}+${s}+L" move-column-right)

    (mk "${m}+${s}+Left" move-column-left)
    (mk "${m}+${s}+Down" move-column-to-workspace-down)
    (mk "${m}+${s}+Up" move-column-to-workspace-up)
    (mk "${m}+${s}+Right" move-column-right)
  ]
  ++ [
    (mk "${m}+${c}+J" move-window-down-or-to-workspace-down)
    (mk "${m}+${c}+K" move-window-up-or-to-workspace-up)

    (mk "${m}+${c}+Down" move-window-down-or-to-workspace-down)
    (mk "${m}+${c}+Up" move-window-up-or-to-workspace-up)
  ]
  ++ [
    (mk "XF86AudioMute" (spawn "wpctl" "set-mute" "@DEFAULT_AUDIO_SINK@" "toggle"))
    (mk "XF86AudioMicMute" (spawn "wpctl" "set-mute" "@DEFAULT_AUDIO_SOURCE@" "toggle"))
    (mk "XF86AudioRaiseVolume" (spawn "wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "5%+"))
    (mk "XF86AudioLowerVolume" (spawn "wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "5%-"))
    (mk "${s}+XF86AudioRaiseVolume" (spawn "wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "10%+"))
    (mk "${s}+XF86AudioLowerVolume" (spawn "wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "10%-"))

    (mk "XF86MonBrightnessUp" (spawn "sudo" "light" "-A" "10"))
    (mk "XF86MonBrightnessDown" (spawn "sudo" "light" "-U" "10"))
    (mk "${s}+XF86MonBrightnessUp" (spawn "sudo" "light" "-S" "70"))
    (mk "${s}+XF86MonBrightnessDown" (spawn "sudo" "light" "-S" "100"))
  ]
  ++ (import ./programs.nix {
    inherit
      config
      mk
      ;
  })
))
// {
  "Mod+1".action = focus-workspace 1;
  "Mod+2".action = focus-workspace 2;
  "Mod+3".action = focus-workspace 3;
  "Mod+4".action = focus-workspace 4;
  "Mod+5".action = focus-workspace 5;
  "Mod+6".action = focus-workspace 6;
  "Mod+7".action = focus-workspace 7;
  "Mod+8".action = focus-workspace 8;
  "Mod+9".action = focus-workspace 9;
  "Mod+0".action = focus-workspace 10;

  "Mod+Shift+1".action = spawn [
    "niri"
    "msg"
    "action"
    "move-column-to-workspace"
    "1"
  ];

  "Mod+Shift+2".action = spawn [
    "niri"
    "msg"
    "action"
    "move-column-to-workspace"
    "2"
  ];

  "Mod+Shift+3".action = spawn [
    "niri"
    "msg"
    "action"
    "move-column-to-workspace"
    "3"
  ];

  "Mod+Shift+4".action = spawn [
    "niri"
    "msg"
    "action"
    "move-column-to-workspace"
    "4"
  ];

  "Mod+Shift+5".action = spawn [
    "niri"
    "msg"
    "action"
    "move-column-to-workspace"
    "5"
  ];

  "Mod+Shift+6".action = spawn [
    "niri"
    "msg"
    "action"
    "move-column-to-workspace"
    "6"
  ];

  "Mod+Shift+7".action = spawn [
    "niri"
    "msg"
    "action"
    "move-column-to-workspace"
    "7"
  ];

  "Mod+Shift+8".action = spawn [
    "niri"
    "msg"
    "action"
    "move-column-to-workspace"
    "8"
  ];

  "Mod+Shift+9".action = spawn [
    "niri"
    "msg"
    "action"
    "move-column-to-workspace"
    "9"
  ];

  "Mod+Shift+0".action = spawn [
    "niri"
    "msg"
    "action"
    "move-column-to-workspace"
    "10"
  ];
}
