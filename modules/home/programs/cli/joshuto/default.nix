{
  x,
  lib,
  config,
  ...
}:
with lib;
with x;
let
  cfg = config.module.programs.cli.joshuto;
in
{
  options = {
    module.programs.cli.joshuto = {
      enable = mkBool;
    };
  };

  config = mkIf cfg.enable { programs.joshuto = on; };
}
