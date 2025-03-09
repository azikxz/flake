{
  lib,
  config,
  ...
}:

with lib;
with x;
let
  cfg = config.module.wm.misc.waybar;
  inherit (config.lib.stylix.colors) base0C;
in

{
  options = {
    module.wm.misc.waybar = {
      enable = mkBool false;
    };
  };

  config = mkIf cfg.enable {
    programs.waybar = on // {
      style = import ./style.nix {
        inherit
          config
          ;
      };
      settings = {
        mainBar =
          let
            Tool.tooltip = false;
            ico = import ./icons.nix;
            wm_icons = ico.wm;
            bat_icons = ico.bat;
            light_icons = ico.light;
          in
          {
            layer = "top";
            position = "bottom";
            height = 1;
            modules-left = [
              "custom/separator"
              "custom/launcher"
              "custom/separator"
              "pulseaudio"
              "custom/separator"
              "backlight"
              "custom/separator"
              "network"
              "custom/separator"
            ];
            modules-center = [ "hyprland/workspaces" ];
            modules-right = [
              "custom/separator"
              "tray"
              "custom/separator"
              "hyprland/language"
              "custom/separator"
              "clock#date"
              "custom/separator"
              "clock#time"
              "custom/separator"
              "battery"
              "custom/separator"
            ];
            "custom/separator" = Tool // {
              format = " ";
            };

            # left modules
            "custom/launcher" = Tool // {
              format = "<span color='#${base0C}' font='17'></span> {}";
              on-click = ''tofi-drun -c ~/.config/tofi/horizontal | xargs hyprctl dispatch exec -- '';
              on-click-right = "tofi-drun | xargs hyprctl dispatch exec -- ";
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
              format = "{icon} {percent}%";
              format-icons = light_icons;
              scroll-step = 1;
              on-click = ''light -S 70'';
              on-click-right = ''light -S 100'';
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
              format-disconnected = " ERR";
              on-click = "kitty nmtui";
              interval = 5;
            };

            # center modules
            "hyprland/workspaces" = Tool // {
              disable-scroll = false;
              on-click = "activate";
              format = "{icon}";
              format-icons = wm_icons;
              persistent-workspaces."*" = [
                1
                2
                3
                4
                5
                6
                7
              ];
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
            # right modules
            "tray" = Tool // {
              icon-size = 18;
              show-passive-items = true;
              spacing = 8;
            };
            "hyprland/language" = Tool // rec {
              format = "{} 󰌌";
              format-en = "EN";
              format-ru = "RU";
              keyboard-name = "at-translated-set-2-keyboard";
              on-click = "hyprctl switchxkblayout ${keyboard-name} next";
            };
            "clock#date" = Tool // {
              format = "{:%d.%m} 󰸘";
              interval = 1;
            };
            "clock#time" = Tool // {
              format = "{:%H:%M} ";
              interval = 1;
            };
            "battery" = Tool // {
              format = "{capacity}% {icon}";
              format-alt = "{time} {icon}";
              format-charging = "{capacity}% 󱐋";
              format-charging-alt = "{capacity}% 󱐋";
              format-full = "{capacity}% 󱈏";
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
