{
  lib,
  ...
}:

with lib;

mkIf (mac "pcRyazenka" || mac "thinkpadT14") {
  services.zapret = {
    enable = true;

    sf_presets = {
      enable = true;
      preset = "general";
    };
  };
}
