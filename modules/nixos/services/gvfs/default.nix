{
  x,
  lib,
  config,
  ...
}:
with lib;
with x;
let
  cfg = config.module.services.gvfs;
in
{
  options = {
    module.services.gvfs = {
      enable = mkBool;
    };
  };

  config = mkIf cfg.enable { services.gvfs = True; };
}
