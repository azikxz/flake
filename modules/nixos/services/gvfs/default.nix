{
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
      enable = mkBool false;
    };
  };

  config = mkIf cfg.enable {
    services.gvfs = on;
  };
}
