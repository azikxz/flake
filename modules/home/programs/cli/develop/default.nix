{
  pkgs,
  lib,
  config,
  ...
}:

with lib;
with x;
let
  cfg = config.module.programs.cli.develop;
in

{
  options = {
    module.programs.cli.develop = {
      enable = mkBool false;
    };
  };

  config = mkIf cfg.enable {
    home.packages = builtins.attrValues {
      inherit (pkgs)
        cachix
        wyvern
        hut
        sd
        ;
    };
  };
}
