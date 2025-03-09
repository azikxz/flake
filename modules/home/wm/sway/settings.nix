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
  seat."*".hide_cursor = "2";
  input."*" = {
    xkb_layout = "us,ru";
    xkb_options = "grp:caps_toggle";
  };
  # BARS
  bars = [ ];
  # AUTOSTART
  startup = with pkgs; [
    { command = "mako"; }
    { command = getExe autotiling-rs; }
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
    let
      mk = a: b: c: d: e: {
        background = a;
        border = b;
        childBorder = c;
        indicator = d;
        text = e;
      };
    in
    with config.lib.stylix.colors.withHashtag;
    mkForce {
      background = base00;
      focused = mk base00 base00 base0B base08 base06;
      focusedInactive = mk base02 base00 base0B base08 base04;
      unfocused = mk base00 base00 base0B base08 base06;
      urgent = mk base00 base08 base0B base08 base06;
    };
}
