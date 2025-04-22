{
  lib,
  config,
  ...
}:

with lib;
with x;
let
  cfg = config.module.programs.gui.nixcord;
in

{
  options = {
    module.programs.gui.nixcord = {
      enable = mkBool false;
    };
  };

  config = mkIf cfg.enable {
    programs.nixcord = on // {
      discord = off;
      vesktop = on;
      config = import ./settings.nix {
        inherit
          lib
          ;
      };
    };
  };
}
