{
  pkgs,
  lib,
  config,
  ...
}:

with lib;
with x;
let
  cfg = config.module.themes.qt;
in

{
  options = {
    module.themes.qt = {
      enable = mkBool false;
    };
  };

  config = mkIf cfg.enable {
    xdg.configFile =
      import ./qtct.nix {
        inherit
          pkgs
          config
          ;
      }
      // import ./color.nix {
        inherit
          lib
          config
          ;
      };
    qt = on // {
      platformTheme.name = "qtct";
    };
  };
}
