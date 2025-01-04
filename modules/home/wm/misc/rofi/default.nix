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
      enable = mkBool;
    };
  };

  config = mkIf cfg.enable {
    programs.rofi = True // {
      location = "bottom";
      terminal = "kitty";
      package = pkgs.rofi-wayland;
      plugins = with pkgs; [
        rofi-file-browser
        rofi-power-menu
        rofi-screenshot
        rofi-bluetooth
        rofi-calc
        rofimoji
      ];
    };
  };
}
