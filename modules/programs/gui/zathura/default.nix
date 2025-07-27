{
  lib,
  config,
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
      font = "${config.stylix.fonts.sansSerif.name} ${toString config.stylix.fonts.sizes.applications}";
    };
  };
}
