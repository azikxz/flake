{
  lib,
  config,
  ...
}:

with lib;
with x;
let
  cfg = config.module.misc.variables;
in

{
  options = {
    module.misc.variables = {
      enable = mkBool false;
    };
  };

  config = mkIf cfg.enable {
    environment.variables = {
      TDESKTOP_I_KNOW_ABOUT_GTK_INCOMPATIBILITY = "1";
      # fff
      FFF_HIDDEN = 1;
      FFF_COL1 = 7;
      FFF_COL2 = 0;
      FFF_COL3 = 3;
      FFF_COL4 = 1;
      FFF_COL5 = 1;
      FFF_FAV1 = x.path.flake;
    };
    xdg.terminal-exec.settings = {
      default = [ "kitty.desktop" ];
    };
  };
}
