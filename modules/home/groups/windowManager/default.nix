{
  lib,
  config,
  ...
}:

with lib;
with x;
let
  cfg = config.module.groups.windowManager;
in

{
  options = {
    module.groups.windowManager = {
      enable = mkBool false;
    };
  };

  config = mkIf cfg.enable {
    module.wm =
      (mkGroup [
        "hyprland"
      ])
      // {
        misc = mkGroup [
          "mako"
          "tofi"
          "wlogout"
        ];
      }
      // {
        terminals = mkGroup [
          "kitty"
        ];
      };
  };
}
