# DUMMY
{
  x,
  lib,
  config,
  ...
}:
with lib;
with x;
let
  cfg = config.module.hardware.disko;
in
{
  options = {
    module.hardware.disko = {
      enable = mkBool;
    };
  };

  config = mkIf cfg.enable { };
}
