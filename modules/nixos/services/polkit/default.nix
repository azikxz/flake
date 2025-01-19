{
  x,
  lib,
  config,
  ...
}:
with lib;
with x;
let
  cfg = config.module.services.polkit;
in
{
  options = {
    module.services.polkit = {
      enable = mkBool;
    };
  };

  config = mkIf cfg.enable {
    security = {
      polkit = on;
      soteria = on;
    };
  };
}
