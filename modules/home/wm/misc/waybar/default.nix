{
  x,
  lib,
  config,
  ...
}:
with lib;
with x;
let
  cfg = config.module.wm.misc.waybar;
in
{
  options = {
    module.wm.misc.waybar = {
      enable = mkBool;
    };
  };

  config = mkIf cfg.enable {
    programs.waybar =
      with config.lib.stylix.colors;
      True
      // {
        settings = {
          # BAR AT BOTTOM
          mainBar =
            let
              Tool = {
                tooltip = false;
              };
              wm_icons = {
                "1" = "一";
                "2" = "二";
                "3" = "三";
                "4" = "四";
                "5" = "五";
                "6" = "六";
                "7" = "七";
                "8" = "八";
                "9" = "九";
                "10" = "十";
              };
              bat_icons = [
                "󰁺"
                "󰁻"
                "󰁼"
                "󰁽"
                "󰁾"
                "󰁿"
                "󰂀"
                "󰂁"
                "󰂂"
                "󰁹"
              ];
              light_icons = [
                "󱩎 "
                "󱩏 "
                "󱩐 "
                "󱩑 "
                "󱩒 "
                "󱩓 "
                "󱩔 "
                "󱩕 "
                "󱩖 "
                "󰛨 "
              ];
              cava_icons = [
                "▁"
                "▂"
                "▃"
                "▄"
                "▅"
                "▆"
                "▇"
                "█"
              ];
            in
            {
              layer = "top";
              position = "bottom";
              height = 1;
              modules-left = [
                "custom/launcher"
                "custom/separatorL"
                "pulseaudio"
                "custom/separatorL"
                "backlight"
                "custom/separatorL"
                "network"
                "custom/separatorL"
                "hyprland/language"
              ];
              modules-center = [ "hyprland/workspaces" ];
              modules-right = [
                "tray"
                "custom/separatorR"
                "disk"
                "custom/separatorR"
                "clock#time"
                "custom/separatorR"
                "battery"
              ];

              # LEFT MODULES
              "custom/launcher" = Tool // {
                format = "<span color='#${base0C}' font='17'></span> {}";
                on-click = "nwg-drawer -ovl -nocats -nofs -d -c 7 -mb -49";
              };
              "custom/separatorL" = Tool // {
                format = "|";
                interval = 1;
              };
              "pulseaudio" = Tool // {
                format = "{icon} {volume}%";
                format-icons = {
                  default = [
                    ""
                    " "
                    " "
                  ];
                  headphone = [ "" ];
                  headset = [ "" ];
                };
                format-muted = "  muted";
                scroll-step = 3;
                on-click = "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
                on-click-right = "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
              };
              "backlight" = Tool // {
                device = "intel_backlight";
                format = "{icon}{percent}%";
                format-icons = light_icons;
                scroll-step = 1;
              };
              "network" = Tool // {
                format-icons = [
                  "󰤯"
                  "󰤟"
                  "󰤢"
                  "󰤥"
                  "󰤨"
                ];
                format-wifi = "{icon} CON";
                format-ethernet = "󰈀 ETH";
                format-disconnected = "⚠ ERR";
                on-click = "kitty nmtui";
                interval = 5;
              };
              "hyprland/language" = Tool // {
                format = "󰌌 {}";
                format-en = "EN";
                format-ru = "RU";
                keyboard-name = "at-translated-set-2-keyboard";
              };
              "cava" = Tool // {
                framerate = 24;
                autosens = 1;
                bars = 12;
                source = "auto";
                format-icons = cava_icons;
                actions = {
                  on-click-right = "mode";
                };
              };

              # CENTER MODULES
              "hyprland/workspaces" = Tool // {
                disable-scroll = false;
                on-click = "activate";
                format = "{icon}";
                format-icons = wm_icons;
                persistent-workspaces = {
                  "*" = [
                    1
                    2
                    3
                    4
                    5
                    6
                    7
                  ];
                };
              };
              "sway/workspaces" = Tool // {
                disable-scroll = false;
                on-click = "activate";
                format = "{icon}";
                format-icons = wm_icons;
                persistent-workspaces = {
                  "1" = [ ];
                  "2" = [ ];
                  "3" = [ ];
                  "4" = [ ];
                  "5" = [ ];
                  "6" = [ ];
                  "7" = [ ];
                };
              };

              # RIGHT MODULES
              "custom/separatorR" = Tool // {
                format = "|";
                interval = 1;
              };
              "tray" = Tool // {
                icon-size = 18;
                show-passive-items = true;
                spacing = 8;
              };
              "disk" = Tool // {
                format = "{used} of {total} 󰋊";
                interval = 30;
                path = "/";
                unit = "GB";
              };
              "clock#time" = Tool // {
                format = "{:%H:%M}  ";
                interval = 1;
              };
              "battery" = Tool // {
                format = "{capacity}% {icon}";
                format-alt = "{time} {icon}";
                format-charging = "{capacity}% 󱐋";
                format-icons = bat_icons;
                states = {
                  critical = 15;
                  warning = 30;
                };
              };
            };
        };
      };
  };
}
