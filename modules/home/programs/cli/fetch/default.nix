{
  lib,
  config,
  ...
}:

with lib;
with x;
let
  cfg = config.module.programs.cli.fetch;
in

{
  options = {
    module.programs.cli.fetch = {
      enable = mkBool false;
    };
  };

  config = mkIf cfg.enable {
    module.programs.cli = {
      countryfetch = on;
      fastfetch = on;
    };
  };
}
