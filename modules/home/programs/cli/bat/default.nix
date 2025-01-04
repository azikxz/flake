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
  cfg = config.module.programs.cli.bat;
in
{
  options.module.programs.cli.bat = {
    enable = mkBool;
  };

  config = mkIf cfg.enable {
    programs.bat = True // {
      extraPackages = with pkgs.bat-extras; [
        # prettybat
        batwatch
        batgrep
        batdiff
      ];
      config = {
        wrap = "character";
      };
    };
  };
}
