{ config, ... }:
let
  cfg = config.module.wm.hyprland;
in
{
  wayland.windowManager.hyprland.settings = {
    layerrule = [ "noanim, notifications" ];
    windowrulev2 = [ ] ++ cfg.rules;
  };
}
