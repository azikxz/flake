{
  x,
  lib,
  config,
  ...
}:
with lib;
with x;
let
  cfg = config.module.programs.cli.eza;
in
{
  options.module.programs.cli.eza = {
    enable = mkBool;
  };

  config = mkIf cfg.enable {
    programs.eza = on // {
      icons = "auto";
      extraOptions = [
        "--group-directories-first"
        "--icons=always"
      ];
    };
  };
}
