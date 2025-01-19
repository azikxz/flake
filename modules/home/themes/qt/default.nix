{
  x,
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
    qt = on // {
      platformTheme.name = "qtct";
    };
  };
}
