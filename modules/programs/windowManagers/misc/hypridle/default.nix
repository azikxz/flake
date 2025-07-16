{
  lib,
  config,
  ...
}:

with lib;

mkIf (mac "thinkpadT14" && config.programs.hyprland.enable) {
  hm.services.hypridle = {
    enable = true;

    settings = {
      general = {
        ignore_dbus_inhibit = false;
        lock_cmd = "pidof hyprlock || hyprlock";

        after_sleep_cmd = "hyprctl dispatch dpms on";
        before_sleep_cmd = "loginctl lock-session";
      };

      listener = [
        {
          timeout = 600;
          on-timeout = "light -S 10";
          on-resume = "light -S 100";
        }

        {
          timeout = 720;
          on-timeout = "hyprctl dispatch dpms off";
          on-resume = "hyprctl dispatch dpms on";
        }

        {
          timeout = 840;
          on-timeout = "systemctl suspend";
        }
      ];
    };
  };
}
