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
  cfg = config.module.programs.cli.top;
in
{
  options = {
    module.programs.cli.top = {
      enable = mkBool false;
    };
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [ nvtopPackages.amd ];
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
