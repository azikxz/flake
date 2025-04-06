{
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
    programs.foot = on // {
      server = off;
      settings = {
        main = {
          font = mkForce (config.stylix.fonts.monospace.name + ":size=12:fontfeatures=");
          pad = "10x10 center";
          resize-by-cells = "yes";
          letter-spacing = 0;
          dpi-aware = mkForce "yes";
        };
        cursor = with config.lib.stylix.colors; {
          style = "block";
          color = base00 + " " + base06;
        };
        mouse = {
          hide-when-typing = "yes";
        };
      };
    };
  };
}
