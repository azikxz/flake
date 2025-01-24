{
  pkgs,
  lib,
  config,
  ...
}:
let
  inherit (lib) getExe mkForce;
  win = {
    border = 2;
    titlebar = false;
  };
in
with config.lib.stylix.colors.withHashtag;
{
  # INPUTS
  seat."*".hide_cursor = "1";
  input."*" = {
    xkb_layout = "us,ru";
    xkb_options = "grp:caps_toggle";
  };
  # BARS
  bars = [ ];
  # AUTOSTART
  startup = with pkgs; [
    { command = "mako"; }
    { command = "${getExe autotiling-rs}"; }
  ];
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
    modifier = "Mod4";
  };
  # COLORS
  colors =
    with config.lib.stylix.colors.withHashtag;
    mkForce {
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
}
