{
  lib,
  config,
  ...
}:

{
  conf = with config.lib.stylix.colors.withHashtag; {
    osd-font = config.stylix.fonts.monospace.name;
    sub-font = config.stylix.fonts.monospace.name;
    background-color = "#000000";
    osd-back-color = base01;
    osd-border-color = base01;
    osd-color = base05;
    osd-shadow-color = base00;
  };
  uosc = {
    uosc.color =
      with config.lib.stylix.colors;
      lib.concatMapAttrsStringSep "," (name: value: "${name}=${value}") {
        background = base00;
        background_text = base05;
        foreground = base05;
        foreground_text = base00;
        curtain = base0D;
        success = base0A;
        error = base0F;
      };
  };
}
