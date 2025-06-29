{
  lib,
  ...
}:

with lib;

mkIf (machine == "pcRyazenka" || machine == "thinkpadT14") {
  hm.programs.zathura = {
    enable = true;

    options = {
      smooth-scroll = true;
      window-title-home-tilde = true;
      statusbar-home-tilde = true;
    };
  };
}
