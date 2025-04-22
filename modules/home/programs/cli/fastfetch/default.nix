{
  lib,
  config,
  ...
}:

with lib;
with x;
let
  cfg = config.module.programs.cli.fastfetch;
in

{
  options = {
    module.programs.cli.fastfetch = {
      enable = mkBool false;
    };
  };

  config = mkIf cfg.enable {
    programs.fastfetch = on // {
      settings = import ./settings.nix;
    };
  };
}
