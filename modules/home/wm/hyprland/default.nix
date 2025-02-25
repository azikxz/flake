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
    wayland.windowManager.hyprland = on // {
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
        // import ./rules.nix { inherit config; }
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
