{
  lib,
  ...
}:

with lib;
# list of available configs
/*
  "general"
  "general_alt"
  "general_alt2"
  "general_alt3"
  "general_alt4"
  "general_alt5"
  "general_alt6"
  "general_mgts"
  "general_mgts2"

  "ultimatefix"
  "ultimatefix_alt"
  "ultimatefix_alt_extended"
  "ultimatefix_universal"
  "ultimatefix_universalv2"
  "ultimatefix_universalv3"
  "ultimatefix_mgts"

  "preset_russia"
  "russiafix"
  "renixos" # very good works
*/

mkIf (mac "pcRyazenka" || mac "thinkpadT14") {
  services.zapret = {
    enable = true;

    sf_presets = {
      enable = true;
      preset = "renixos";
    };
  };
}
