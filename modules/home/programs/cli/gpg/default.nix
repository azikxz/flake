{
  x,
  lib,
  config,
  ...
}:
with lib;
with x;
let
  cfg = config.module.programs.cli.gpg;
in
{
  options = {
    module.programs.cli.gpg = {
      enable = mkBool;
    };
  };

  config = mkIf cfg.enable {
    programs.gpg = True // {

    };
  };
}
