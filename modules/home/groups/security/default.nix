{
  lib,
  config,
  ...
}:

with lib;
with x;
let
  cfg = config.module.groups.security;
in

{
  options = {
    module.groups.security = {
      enable = mkBool false;
    };
  };

  config = mkIf cfg.enable {
    module.programs.gui = mkGroup [
      "keepass"
      "syncthing"
    ];
  };
}
