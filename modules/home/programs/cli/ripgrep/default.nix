{
  x,
  lib,
  config,
  ...
}:
with lib;
with x;
let
  cfg = config.module.programs.cli.ripgrep;
in
{
  options = {
    module.programs.cli.ripgrep = {
      enable = mkBool false;
    };
  };

  config = mkIf cfg.enable {
    programs.ripgrep = on;
  };
}
