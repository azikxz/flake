{
  x,
  lib,
  config,
  ...
}:
with lib;
with x;
let
  cfg = config.module.wm.terminals.kitty;
in
{
  options = {
    module.wm.terminals.kitty = {
      enable = mkBool;
    };
  };

  config = mkIf cfg.enable { programs.kitty = True // { }; };
}
