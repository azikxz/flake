{
  lib,
  config,
  ...
}:

with lib;

{
  mainBar =
    let
      mkTooltip.tooltip = false;
      ico = import ./icons.nix;
    in
    mkMerge [
      {
        start_hidden = if (machine != "thinkpadT14") then true else false;
        layer = "top";
        position = "bottom";
        height = 1;

        "custom/separator" = mkTooltip // {
          format = " ";
        };
      }
      (
        if (machine == "thinkpadT14") then
          {
            modules-left = [
              "custom/separator"
              "custom/launcher"
              "custom/separator"
              "custom/separator"
              "wireplumber#audio"
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
              "custom/power"
              "custom/separator"
            ];
          }
        else
          {
            modules-left = [
              "custom/separator"
              "custom/launcher"
              "custom/separator"
              "wireplumber#audio"
              "custom/separator"
              "hyprland/language"
              "custom/separator"
            ];

            modules-center = [ "hyprland/workspaces" ];

            modules-right = [
              "custom/separator"
              "tray"
              "custom/separator"
              "clock#date"
              "custom/separator"
              "clock#time"
              "custom/separator"
              "custom/power"
              "custom/separator"
            ];
          }
      )
      {
        # left modules
        "custom/launcher" = mkTooltip // {
          format = "<span color='${config.lib.stylix.colors.withHashtag.base00}' font='17'></span> {}";

          on-click = ''tofi-drun -c ~/.config/tofi/horizontal | xargs hyprctl dispatch exec -- '';
          on-click-right = "tofi-drun | xargs hyprctl dispatch exec -- ";
        };

        "wireplumber#audio" = mkTooltip // {
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

          scroll-step = 5;
          max-volume = 100;
          on-click = "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
        };

        "wireplumber#microphone" = mkTooltip // {
          format = "{icon}";
          format-icons = [
            "󰍬 "
            "󰍭 "
          ];
          format-muted = "󰍭 ";

          on-click = "wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle";
        };

        "backlight" = mkTooltip // {
          device = "intel_backlight";

          format = "{icon} {percent}%";
          format-icons = ico.light;

          scroll-step = 1;
          on-click = ''light -S 70'';
          on-click-right = ''light -S 100'';
        };

        "network" = mkTooltip // {
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

          on-click = "nm-applet --indicator";
          on-click-right = "nm-applet";

          interval = 5;
        };

        disk = mkTooltip // {
          format = " {used}/{total}";
          path = config.users.users.${system.userName}.home;
          unit = "GB";

          interval = 30;
        };
      }
      {
        # center modules
        "hyprland/workspaces" = mkTooltip // {
          format = "{icon}";
          format-icons = ico.wm // {
            "active" = "";
          };

          disable-scroll = false;
          on-click = "activate";

          persistent-workspaces."*" = range 1 7;
        };

        "sway/workspaces" = mkTooltip // {
          format = "{icon}";
          format-icons = ico.wm;

          disable-scroll = false;
          on-click = "activate";

          persistent-workspaces = genAttrs (map (n: toString n) (range 1 7)) (n: [ ]);
        };
      }
      {
        # right modules
        "tray" = mkTooltip // {
          icon-size = 18;
          show-passive-items = true;
          spacing = 8;
        };

        "hyprland/language" = mkTooltip // rec {
          format = if (machine == "thinkpadT14") then "{} 󰌌" else "󰌌 {}";
          format-en = "EN";
          format-ru = "RU";

          keyboard-name = "at-translated-set-2-keyboard";

          on-click = "hyprctl switchxkblayout ${keyboard-name} next";
        };

        "clock#date" = mkTooltip // {
          format = "{:%d.%m} 󰸘";

          interval = 1;
        };

        "clock#time" = mkTooltip // {
          format = "{:%H:%M} ";

          interval = 1;
        };

        "battery" = mkTooltip // {
          format = "{capacity}% {icon}";
          format-alt = "{time} {icon}";
          format-charging = "{capacity}% 󱐋";
          format-charging-alt = "{capacity}% 󱐋";
          format-full = "{capacity}% 󱈏";
          format-icons = ico.bat;

          states = {
            critical = 15;
            warning = 30;
            good = 95;
          };
        };

        "custom/power" = mkTooltip // {
          format = " ";
          on-click = "wlogout -sc 12 -r 12";
        };
      }
    ];
}
