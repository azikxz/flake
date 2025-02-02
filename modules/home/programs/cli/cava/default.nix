{
  x,
  lib,
  config,
  ...
}:
with lib;
with x;
let
  cfg = config.module.programs.cli.cava;
in
{
  options = {
    module.programs.cli.cava = {
      enable = mkBool false;
    };
  };

  config = mkIf cfg.enable {
    programs.cava = on;
  };
}
