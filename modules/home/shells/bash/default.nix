{
  lib,
  config,
  ...
}:

with lib;
with x;
let
  cfg = config.module.shells.bash;
in

{
  options = {
    module.shells.bash = {
      enable = mkBool false;
    };
  };

  config = mkIf cfg.enable {
    programs.bash = off;
  };
}
