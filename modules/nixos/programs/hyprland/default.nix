{
  x,
  lib,
  config,
  ...
}:
with lib;
with x;
let
  cfg = config.module.programs.hyprland;
in
{
  options = {
    module.programs.hyprland = {
      enable = mkBool false;
    };
  };

  config = mkIf cfg.enable { programs.hyprland = on; };
}
