{
  lib,
  config,
  ...
}:

with lib;
with x;
let
  cfg = config.module.shells.starship;
in

{
  options = {
    module.shells.starship = {
      enable = mkBool false;
    };
  };

  config = mkIf cfg.enable {
    programs.starship = on // {
      enableTransience = true;
      settings = import ./settings.nix {
        inherit
          lib
          ;
      };
    };
  };
}
