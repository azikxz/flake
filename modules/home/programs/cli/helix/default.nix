{
  x,
  lib,
  config,
  ...
}:
with lib;
with x;
let
  cfg = config.module.programs.cli.helix;
in
{
  options = {
    module.programs.cli.helix = {
      enable = mkBool;
    };
  };

  config = mkIf cfg.enable {
    programs.helix = True // {
      defaultEditor = true;
    };
  };
}
