{
  lib,
  config,
  ...
}:

with lib;
with x;
let
  cfg = config.module.programs.cli.btop;
in

{
  options = {
    module.programs.cli.btop = {
      enable = mkBool false;
    };
  };

  config = mkIf cfg.enable {
    programs.btop = on // {
      settings = {
        update_ms = 100;
        color_theme = "TTY";
        theme_background = true;
        vim_keys = true;
        rounded_corners = true;
      };
    };
  };
}
