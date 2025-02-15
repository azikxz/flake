{
  pkgs,
  lib,
  config,
  ...
}:

with lib;
with x;
let
  cfg = config.module.wm.sway;
in

{
  options = {
    module.wm.sway = {
      enable = mkBool false;
    };
  };

  config = mkIf cfg.enable {
    wayland.windowManager.sway = on // {
      package = pkgs.swayfx;
      config = import ./sets.nix { inherit pkgs lib config; } // {
        keybindings = import ./binds.nix { inherit pkgs lib; };
      };
      extraConfig =
        with config.lib.stylix.colors.withHashtag;
        # fish
        ''
          corner_radius 10
          blur enable
          blur_xray on
          shadows enable
          shadows_on_csd enable
          shadow_color ${base00}
          shadow_blur_radius 12
          default_dim_inactive 0.4
          layer_effects "waybar" shadows disable; corner_radius 0; blur disable
        '';
      checkConfig = false;
      xwayland = true;
      systemd = on;
    };
  };
}
