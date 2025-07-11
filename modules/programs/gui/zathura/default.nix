{
  lib,
  ...
}:

with lib;

mkIf (mac "pcRyazenka" || mac "thinkpadT14") {
  hm.programs.zathura = {
    enable = true;

    options = {
      smooth-scroll = true;
      window-title-home-tilde = true;
      statusbar-home-tilde = true;
    };
  };
}
