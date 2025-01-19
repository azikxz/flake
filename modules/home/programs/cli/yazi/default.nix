{
  x,
  lib,
  config,
  ...
}:
with lib;
with x;
let
  cfg = config.module.programs.cli.yazi;
in
{
  options = {
    module.programs.cli.yazi = {
      enable = mkBool;
    };
  };

  config = mkIf cfg.enable { programs.yazi = on // { }; };
}
