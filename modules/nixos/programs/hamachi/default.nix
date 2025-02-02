{
  x,
  lib,
  config,
  ...
}:
with lib;
with x;
let
  cfg = config.module.programs.hamachi;
in
{
  options = {
    module.programs.hamachi = {
      enable = mkBool false;
    };
  };

  config = mkIf cfg.enable { programs.haguichi = on; };
}
