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
      enable = mkBool;
    };
  };

  # imports = with inputs; [ hyprland.nixosModules.default ];
  config = mkIf cfg.enable {
    programs.hyprland = on;
  };
}
