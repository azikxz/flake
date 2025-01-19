{
  x,
  pkgs,
  lib,
  config,
  ...
}:
with lib;
with x;
let
  cfg = config.module.programs.sway;
in
{
  options = {
    module.programs.sway = {
      enable = mkBool;
    };
  };

  config = mkIf cfg.enable {
    programs.sway = on // {
      package = pkgs.swayfx;
    };
  };
}
