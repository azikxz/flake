{
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
    impermanence.dirs = [
      ".local/share/syncthing"
      ".local/state/syncthing"
    ];
    services.syncthing = on;
  };
}
