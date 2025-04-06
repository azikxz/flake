{
  config,
  ...
}:

with config.lib.niri.actions;
let
  m = "Mod";
  s = "Shift";
  a = "Alt";
in

{
  "${m}+Q".action = close-window;
  "${m}+Grave".action = quit;
  "${m}+${s}+Grave".action = quit { skip-confirmation = true; };

  "${m}+Return".action = spawn "kitty";
  "${m}+Tab".action = spawn "tofi-drun | xargs h";

  "${m}+Space".action = toggle-window-floating;
  "${m}+${a}+Space".action = switch-focus-between-floating-and-tiling;

  "${m}+F".action = maximize-column;
  "${m}+${s}+F".action = fullscreen-window;
  "${m}+C".action = center-window;
  "${m}+${s}+C".action = center-column;

  "Print".action = screenshot;
  "${s}+Print".action = screenshot-window;

  "${m}+S".action = switch-preset-column-width;
  "${m}+Comma".action = consume-window-into-column;
  "${m}+Period".action = expel-window-from-column;

  "${m}+Minus".action = set-column-width "-10%";
  "${m}+Plus".action = set-column-width "+10%";
  "${m}+${s}+Minus".action = set-window-height "-10%";
  "${m}+${s}+Plus".action = set-window-height "+10%";

  # hjkl
  "${m}+H".action = focus-column-left;
  "${m}+J".action = focus-window-or-workspace-down;
  "${m}+K".action = focus-window-or-workspace-up;
  "${m}+L".action = focus-column-right;
  # arrows
  "${m}+Left".action = focus-column-left;
  "${m}+Down".action = focus-workspace-down;
  "${m}+Up".action = focus-workspace-up;
  "${m}+Right".action = focus-column-right;
  # hjkl
  "${m}+${s}+H".action = move-column-left;
  "${m}+${s}+J".action = move-column-to-workspace-down;
  "${m}+${s}+K".action = move-column-to-workspace-up;
  "${m}+${s}+L".action = move-column-right;
  # arrows
  "${m}+${s}+Left".action = move-column-left;
  "${m}+${s}+Down".action = move-column-to-workspace-down;
  "${m}+${s}+Up".action = move-column-to-workspace-up;
  "${m}+${s}+Right".action = move-column-right;

  "${m}+${a}+J".action = move-column-to-monitor-down;
  "${m}+${a}+K".action = move-column-to-monitor-up;
}
// {
  # sound
  "XF86AudioMute".action = spawn "wpctl" "set-mute" "@DEFAULT_AUDIO_SINK@" "toggle";
  "XF86AudioMicMute".action = spawn "wpctl" "set-mute" "@DEFAULT_AUDIO_SOURCE@" "toggle";
  # volume
  "XF86AudioRaiseVolume".action = spawn "wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "5%+";
  "XF86AudioLowerVolume".action = spawn "wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "5%-";
  "${s}+XF86AudioRaiseVolume".action = spawn "wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "10%+";
  "${s}+XF86AudioLowerVolume".action = spawn "wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "10%-";
  # brighness
  "XF86MonBrightnessUp".action = spawn "sudo" "light" "-A" "10";
  "XF86MonBrightnessDown".action = spawn "sudo" "light" "-U" "10";
  "${s}+XF86MonBrightnessUp".action = spawn "sudo" "light" "-S" "70";
  "${s}+XF86MonBrightnessDown".action = spawn "sudo" "light" "-S" "100";
}
// {
  "${m}+1".action = focus-workspace 1;
  "${m}+2".action = focus-workspace 2;
  "${m}+3".action = focus-workspace 3;
  "${m}+4".action = focus-workspace 4;
  "${m}+5".action = focus-workspace 5;
  "${m}+6".action = focus-workspace 6;
  "${m}+7".action = focus-workspace 7;
  "${m}+8".action = focus-workspace 8;
  "${m}+9".action = focus-workspace 9;
  "${m}+10".action = focus-workspace 10;

  "${m}+Shift+1".action = move-column-to-workspace 1;
  "${m}+Shift+2".action = move-column-to-workspace 2;
  "${m}+Shift+3".action = move-column-to-workspace 3;
  "${m}+Shift+4".action = move-column-to-workspace 4;
  "${m}+Shift+5".action = move-column-to-workspace 5;
  "${m}+Shift+6".action = move-column-to-workspace 6;
  "${m}+Shift+7".action = move-column-to-workspace 7;
  "${m}+Shift+8".action = move-column-to-workspace 8;
  "${m}+Shift+9".action = move-column-to-workspace 9;
  "${m}+Shift+10".action = move-column-to-workspace 10;
}
