{
  sway,
  pkgs,
  lib,
  config,
  ...
}:

let
  inherit (config.xdg.userDirs.extraConfig)
    XDG_SCREENSHOTS_DIR
    ;
  inherit (sway)
    modifier
    terminal
    menu
    ;
  act = import ./focus2ws.nix {
    inherit
      sway
      lib
      ;
  };
  # useful
  exec = "exec ";
  pic = " ${XDG_SCREENSHOTS_DIR}/$(date +'scr_%d-%m-%y_%H:%M:%S.png')";
  grilurp = n: exec + (lib.getExe pkgs.grilurp) + " copysave " + n + pic;
  # functions
  mkProgram' = pre: data: lib.concatMapAttrs pre data;
  mkProgram =
    attrs:
    (mkProgram' (key: cmd: {
      "${modifier}+${key}" = cmd;
    }) attrs);
in

(mkProgram {
  "Q" = "kill";
  "F" = "fullscreen";

  "Space" = "floating toggle; " + "resize set 90 ppt 90 ppt";
  "Alt+Space" = "move position center";

  "G" = "layout tabbed";
  "Shift+G" = "layout toggle split";

  "bracketleft" = "split h";
  "bracketright" = "split v";

  "P" = "move scratchpad";
  "Shift+P" = "scratchpad show";
  "Alt+P" = "scratchpad show; " + "floating toggle";

  "R" = "mode resize";
  "Shift+R" = "mode gapsMode";

  "Home" = "exit";
  "Shift+Home" = "reload";

  "Tab" = exec + menu;
  "Return" = exec + terminal;
  "Shift+Return" = exec + terminal + " --class=termfloat";
  "B" = "qutebrowser";
  "Shift+B" = "keepassxc";
  "V" = "telegram-desktop";
  "Shift+V" = "vesktop";
  "N" = "kitty yazi";
  "Shift+N" = "kitty --class=termfloat yazi";
  "M" = "spotify";
  "Shift+M" = "kitty --class=ani anicli-ru -q 1080";
})
// {
  # screenshots
  "Print" = grilurp "anything";
  "Print+Shift" = grilurp "output";
  "Print+Alt" = grilurp "active";
}
// {
  # sound
  "XF86AudioMute" = exec + "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
  "XF86AudioMicMute" =
    exec
    + (lib.getExe (
      pkgs.writeShellScriptBin "micMute" ''
        fixf4=$(cat /sys/class/leds/platform\:\:micmute/brightness);
        echo $((1-fixf4)) | sudo tee /sys/class/leds/platform\:\:micmute/brightness;
        wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle
      ''
    ));
  "XF86AudioRaiseVolume" = exec + "wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+";
  "XF86AudioLowerVolume" = exec + "wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-";
  "Shift+XF86AudioRaiseVolume" = exec + "wpctl set-volume @DEFAULT_AUDIO_SINK@ 10%+";
  "Shift+XF86AudioLowerVolume" = exec + "wpctl set-volume @DEFAULT_AUDIO_SINK@ 10%-";
}
// {
  "XF86Favorites" = "wlogout -sc 12 -r 12";
  "Shift+XF86Favorites" = "poweroff";
  "Alt+XF86Favorites" = "reboot";
  "XF86HangupPhone" = "makoctl dismiss -a";
  "Shift+XF86HangupPhone" = "makoctl restore";
}
// act.workspacesAndMove
// act.resizeWindow
// act.moveAndFocus
