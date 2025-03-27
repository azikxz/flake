{
  config,
  ...
}:

{
  mainBar =
    let
      mkTooltip.tooltip = false;
      ico = import ./icons.nix;
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
      "custom/separator" = mkTooltip // {
        format = " ";
      };

      # left modules
      "custom/launcher" = mkTooltip // {
        format = "<span color='${config.lib.stylix.colors.withHashtag.base0C}' font='17'></span> {}";
        on-click = ''tofi-drun -c ~/.config/tofi/horizontal | xargs hyprctl dispatch exec -- '';
        on-click-right = "tofi-drun | xargs hyprctl dispatch exec -- ";
      };
      "pulseaudio" = mkTooltip // {
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
        on-click = "kitty nmtui";
        interval = 5;
      };

      # center modules
      "hyprland/workspaces" = mkTooltip // {
        disable-scroll = false;
        on-click = "activate";
        format = "{icon}";
        format-icons = ico.wm;
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
      "sway/workspaces" = mkTooltip // {
        disable-scroll = false;
        on-click = "activate";
        format = "{icon}";
        format-icons = ico.wm;
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
      "tray" = mkTooltip // {
        icon-size = 18;
        show-passive-items = true;
        spacing = 8;
      };
      "hyprland/language" = mkTooltip // rec {
        format = "{} 󰌌";
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
        };
      };
    };
}
