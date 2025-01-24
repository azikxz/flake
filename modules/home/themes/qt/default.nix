{
  x,
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
      enable = mkBool;
    };
  };

  config = mkIf cfg.enable {
    xdg.configFile =
      import ./qtct.nix { inherit pkgs config; }
      // import ./color.nix { inherit x config; };
    qt = on // {
      platformTheme.name = "qtct";
    };
  };
}
