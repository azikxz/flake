{
  x,
  lib,
  config,
  ...
}:
with lib;
with x;
let
  cfg = config.module.programs.gui.zathura;
in
{
  options = {
    module.programs.gui.zathura = {
      enable = mkBool;
    };
  };

  config = mkIf cfg.enable {
    programs.zathura = on // {
      options = {
        smooth-scroll = true;
        window-title-home-tilde = true;
        statusbar-home-tilde = true;
      };
    };
  };
}
