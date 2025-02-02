{
  x,
  pkgs,
  lib,
  config,
  ...
}:
with lib;
with x;
let
  cfg = config.module.wm.misc.rofi;
in
{
  options = {
    module.wm.misc.rofi = {
      enable = mkBool false;
    };
  };

  config = mkIf cfg.enable {
    programs.rofi = on // {
      location = "bottom";
      terminal = "kitty";
      package = pkgs.rofi-wayland;
    };
  };
}
