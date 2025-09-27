{
  pkgs,
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
        start_hidden = if (mac' "thinkpadT14") then true else false;
        layer = "top";
        position = "bottom";
        height = 1;

        "custom/separator" = mkTooltip // {
          format = " ";
        };
      }
      (
        if (mac "thinkpadT14") then
          {
            modules-left = [
              "custom/separator"
              "custom/launcher"
              "custom/separator"
              "group/soundGrp"
              "custom/separator"
              "backlight"
              "custom/separator"
              "group/blueGrp"
              "custom/separator"
            ];

            modules-center = [ "hyprland/workspaces" ];

            modules-right = [
              "custom/separator"
              "tray"
              "custom/separator"
              "hyprland/language"
              "custom/separator"
              "group/dateGrp"
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
              "group/soundGrp"
              "custom/separator"
              "hyprland/language"
              "custom/separator"
              "group/blueGrp"
              "custom/separator"
            ];

            modules-center = [ "hyprland/workspaces" ];

            modules-right = [
              "custom/separator"
              "tray"
              "custom/separator"
              "group/dateGrp"
              "custom/separator"
              "custom/power"
              "custom/separator"
            ];
          }
      )
      {
        # left modules
        "custom/launcher" = mkTooltip // {
          format = "<span color='${config.lib.stylix.colors.withHashtag.base0C}' font='17'></span> {}";

          on-click = "tofi-drun | xargs hyprctl dispatch exec -- ";
        };

        "pulseaudio#volume" = mkTooltip // {
          format = "{volume}%";
          format-muted = "muted";

          format-bluetooth = "{volume}%";
          format-bluetooth-muted = "muted";
        };

        "pulseaudio" = mkTooltip // {
          format = "{format_source} / {icon}";
          format-icons = {
            default = [
              ""
              " "
              " "
            ];
            headphone = [ "" ];
            headset = [ "" ];
            bluetooth = "";
            bluetooth-muted = "󰂲";
          };
          format-muted = "{format_source} /  ";

          format-source = "󰍬";
          format-source-muted = "󰍭";

          scroll-step = 5;
          max-volume = 100;
          on-click = "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
          on-click-right = "wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle";
        };

        "backlight" = mkTooltip // {
          device = "intel_backlight";

          format = "{icon}{percent}%";
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
          format-wifi = "{icon} ";
          format-ethernet = "󰈀";
          format-disconnected = "";

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

          all-outputs = false;
          disable-scroll = false;
          on-click = "activate";

          persistent-workspaces."*" = range 1 10;
        };
      }
      {
        # right modules
        "tray" = mkTooltip // {
          icon-size = 18;
          show-passive-items = true;
          spacing = 8;
        };

        "custom/amneziawg" = mkTooltip // {
          format = "{text}";
          # INFO: text = interface name
          #       icon = connceted or not
          interval = 1;

          exec = "${getExe pkgs.self'.waybar-awg} show";
          on-click = getExe pkgs.self'.waybar-awg;

          return-type = "json";
        };

        "bluetooth#name" = mkTooltip // {
          format = "{status}";
          format-disabled = "";

          format-connected = "{device_alias}";
          format-connected-battery = "{device_alias} ({device_battery_percentage}%)";

          on-click = getExe pkgs.self'.wofi-bt;
          on-click-right = "bluetoothctl disconnect";
        };

        "bluetooth" = mkTooltip // {
          format = "󰂲";
          format-disabled = "󰂲";

          format-connected = "󰂰 ({num_connections})";
          format-connected-battery = "󰂳 ({num_connections})";

          on-click = getExe pkgs.self'.wofi-bt;
          on-click-right = "bluetoothctl disconnect";
        };

        "hyprland/language" = mkTooltip // rec {
          format = if (mac "thinkpadT14") then "{} 󰌌" else "󰌌 {}";
          format-en = "en";
          format-ru = "ru";

          keyboard-name =
            if (mac "thinkpadT14") then
              "at-translated-set-2-keyboard"
            else if (mac "pcRyazenka") then
              "by-tech-patron"
            else
              "unknown";

          on-click = "hyprctl switchxkblayout ${keyboard-name} next";
        };

        "clock#date" = mkTooltip // {
          format = "{:%d.%m.%Y} ";

          interval = ((60 * 60) * 24);
        };

        "clock#time" = mkTooltip // {
          format = "{:%H:%M} 󰥔";

          interval = 1;
        };

        "battery" = mkTooltip // {
          format = "{capacity}% {icon}";
          format-alt = "{time} {icon}";
          format-charging = "{capacity}% 󰂄";
          format-charging-alt = "{capacity}% 󰂄";
          format-plugged = "{capacity}% ";
          format-full = "{capacity}% 󱟢";
          format-icons = ico.bat;

          states = {
            critical = 15;
            warning = 30;
            good = 95;
          };

          interval = 1;
        };

        "custom/power" = mkTooltip // {
          format = "⏻";
          on-click = "wleave";
        };
      }
      (
        let
          mkGroup = drawer: modules: {
            inherit drawer modules;
            orientation = "inherit";
          };
        in
        {
          "group/soundGrp" =
            mkGroup
              {
                transition-duration = 300;
                children-class = "soundGrp";
                transition-left-to-right = true;
              }
              [
                "pulseaudio"
                "pulseaudio#volume"
              ];

          "group/blueGrp" =
            mkGroup
              {
                transition-duration = 300;
                children-class = "blueGrp";
                transition-left-to-right = true;
              }
              [
                "bluetooth"
                "bluetooth#name"
              ];

          "group/dateGrp" =
            mkGroup
              {
                transition-duration = 300;
                children-class = "dateGrp";
                transition-left-to-right = false;
              }
              [
                "clock#time"
                "clock#date"
                "custom/separator"
              ];
        }
      )
    ];
}
