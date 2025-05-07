{
  pkgs,
  lib,
  config,
  ...
}:

with lib;
with x;
let
  cfg = config.module.wm.hyprland;
  nixosCfg = config'.programs.hyprland.enable;
in

{
  options = {
    module.wm.hyprland = {
      enable = mkBool false;
      autostart = mkList.str [ ];
      binds = mkList.str [ ];
    };
  };

  config = mkIf cfg.enable {
    wayland.windowManager.hyprland = (if nixosCfg then on else off) // {
      xwayland = on;
      systemd = on;
      settings =
        import ./binds.nix {
          inherit
            pkgs
            lib
            config
            ;
        }
        // import ./rules.nix {
          inherit
            lib
            config
            ;
        }
        // import ./settings.nix {
          inherit
            pkgs
            lib
            config
            ;
        };
    };
  };
}
