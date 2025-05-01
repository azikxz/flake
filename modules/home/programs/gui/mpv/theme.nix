{
  lib,
  config,
  ...
}:

let
  colors = config.lib.stylix.colors;
  fonts = config.stylix.fonts.monospace.name;
in

{
  conf = with colors.withHashtag; {
    osd-font = fonts;
    sub-font = fonts;
    background-color = "#000000";
    osd-back-color = base01;
    osd-border-color = base01;
    osd-color = base05;
    osd-shadow-color = base00;
  };
  uosc.uosc.color =
    with colors;
    lib.concatMapAttrsStringSep "," (name: value: "${name}=${value}") {
      background = base00;
      background_text = base05;
      foreground = base05;
      foreground_text = base00;
      curtain = base0D;
      success = base0A;
      error = base0F;
    };
}
