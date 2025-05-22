{
  lib,
  ...
}:

with lib;

mkIf (itIs == "desktop" || itIs == "laptop") {
  hm.programs.zathura = {
    enable = true;

    options = {
      smooth-scroll = true;
      window-title-home-tilde = true;
      statusbar-home-tilde = true;
    };
  };
}
