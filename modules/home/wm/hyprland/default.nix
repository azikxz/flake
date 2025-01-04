{
  x,
  inputs,
  lib,
  config,
  ...
}:
with lib;
with x;
let
  cfg = config.module.wm.hyprland;
in
{
  options = {
    module.wm.hyprland = {
      enable = mkBool;
      autostart = mkOpt.list.str;
      binds = mkOpt.list.str;
      rules = mkOpt.list.str;
    };
  };

  imports = with inputs; [ hyprland.homeManagerModules.default ];
  config = mkIf cfg.enable {
    wayland.windowManager.hyprland = True // {
      xwayland = True;
      systemd = True;
    };
  };
}
