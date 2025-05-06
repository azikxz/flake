{
  lib,
  config,
  ...
}:

with config.lib.stylix.colors.withHashtag;
let
  background = base00;
  mk = color: {
    inherit background;
    border = color;
    childBorder = color;
    indicator = color;
    text = base05;
  };
in

lib.mkForce {
  inherit background;
  focused = mk base0E;
  focusedInactive = mk base01;
  unfocused = mk base01;
  urgent = mk base08;
  placeholder = mk base01;
}
