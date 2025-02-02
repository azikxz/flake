{
  x,
  inputs,
  pkgs,
  lib,
  config,
  ...
}:
with lib;
with x;
let
  cfg = config.module.wm.hyprland;
in
{
  options = {
    module.wm.hyprland = {
      enable = mkBool false;
      autostart = mkList.str [ ];
      binds = mkList.str [ ];
    };
  };

  imports = with inputs; [ hyprland.homeManagerModules.default ];
  config = mkIf cfg.enable {
    wayland.windowManager.hyprland = on // {
      xwayland = on;
      systemd = on;
      settings =
        import ./binds.nix {
          inherit
            x
            pkgs
            lib
            config
            ;
        }
        // import ./rules.nix { inherit x lib config; }
        // import ./sets.nix {
          inherit
            x
            pkgs
            lib
            config
            ;
        };
    };
  };
}
