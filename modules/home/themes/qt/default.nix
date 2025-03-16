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
    xdg.configFile = import ./qtct.nix {
      inherit
        pkgs
        lib
        config
        ;
    };
    qt = on // {
      platformTheme.name = "qtct";
    };
  };
}
