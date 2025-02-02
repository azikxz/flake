{
  x,
  lib,
  config,
  ...
}:
with lib;
with x;
let
  cfg = config.module.programs.gui.syncthing;
in
{
  options = {
    module.programs.gui.syncthing = {
      enable = mkBool false;
    };
  };

  config = mkIf cfg.enable {
    services.syncthing = on;
  };
}
