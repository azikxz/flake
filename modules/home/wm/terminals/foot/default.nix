{
  x,
  lib,
  config,
  ...
}:
with lib;
with x;
let
  cfg = config.module.wm.terminals.foot;
in
{
  options = {
    module.wm.terminals.foot = {
      enable = mkBool false;
    };
  };

  config = mkIf cfg.enable {
    programs.foot =
      with config.lib.stylix.colors;
      on
      // {
        server = off;
        settings = {
          main = {
            font = lib.mkForce "JetBrainsMono Nerd Font:size=12:fontfeatures=";
            pad = "10x10 center";
            resize-by-cells = "yes";
            letter-spacing = 0;
            dpi-aware = lib.mkForce "yes";
            # bold-text-in-bright = "yes";
          };
          cursor = {
            style = "block";
            color = "${base00} ${base06}";
          };
          mouse = {
            hide-when-typing = "yes";
          };
        };
      };
  };
}
