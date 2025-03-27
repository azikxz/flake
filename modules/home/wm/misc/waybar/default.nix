{
  lib,
  config,
  ...
}:

with lib;
with x;
let
  cfg = config.module.wm.misc.waybar;
in

{
  options = {
    module.wm.misc.waybar = {
      enable = mkBool false;
    };
  };

  config = mkIf cfg.enable {
    programs.waybar = on // {
      style = import ./style.nix {
        inherit
          config
          ;
      };
      settings = import ./settings.nix {
        inherit
          config
          ;
      };
    };
  };
}
