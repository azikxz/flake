{
  pkgs,
  lib,
  config,
  ...
}:
with lib;
let
  font = config.stylix.fonts;
  win = {
    border = 1;
    titlebar = false;
  };
in
{
  wayland.windowManager.sway = with config.lib.stylix.colors.withHashtag; {
    config = with pkgs; rec {
      # INPUTS
      seat."*".hide_cursor = "1";
      input."*" = {
        xkb_layout = "us,ru";
        xkb_options = "grp:caps_toggle";
      };
      # BARS
      bars = [ ];
      # AUTOSTART
      startup = [
        { command = "${mako}/bin/mako"; }
        { command = "${autotiling-rs}/bin/autotiling-rs"; }
      ];
      fonts.names = [ "${font.monospace.name}" ];
      # MOVEMENT & BINDS
      modifier = "Mod4";
      bindkeysToCode = true;
      workspaceAutoBackAndForth = true;
      # DECORATIONS
      gaps = {
        inner = 4;
        outer = 4;
        smartBorders = "on";
        smartGaps = true;
      };
      window = win // {
        hideEdgeBorders = "smart";
      };
      floating = win // {
        inherit modifier;
      };
      # COLORS
      colors = mkForce {
        background = "${base00}";
        focused = {
          background = "${base00}";
          border = "${base00}";
          childBorder = "${base0B}";
          indicator = "${base08}";
          text = "${base06}";
        };
        focusedInactive = {
          background = "${base02}";
          border = "${base00}";
          childBorder = "${base0B}";
          indicator = "${base08}";
          text = "${base04}";
        };
        unfocused = {
          background = "${base00}";
          border = "${base00}";
          childBorder = "${base0B}";
          indicator = "${base08}";
          text = "${base06}";
        };
        urgent = {
          background = "${base00}";
          border = "${base08}";
          childBorder = "${base0B}";
          indicator = "${base08}";
          text = "${base06}";
        };
      };
    };
    extraConfig = # sh
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
  };
}
