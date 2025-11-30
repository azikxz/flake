{
  lib,
  ...
}:

with lib;
let
  revision = "zapret"; # zapret / zapret-alt
in

mkIf (mac "pcRyazenka" || mac "thinkpadT14") (
  if (revision == "zapret-alt") then
    # INFO / zapret-alt:
    # list of available configs
    /*
      general
      general(ALT)
      general(ALT2)
      general(ALT3)
      general(ALT4)
      general(ALT5)
      general(ALT6)
      general(ALT7)
      general(ALT8)
      general(ALT9)
      general(ALT10)
      general (FAKE_TLS_AUTO)
      general (FAKE_TLS_AUTO_ALT)
      general (FAKE_TLS_AUTO_ALT2)
      general (FAKE_TLS_AUTO_ALT3)
      general (SIMPLE FAKE)
      general (SIMPLE FAKE ALT)
    */
    {
      services = {
        zapret.enable = mkForce false;

        zapret-discord-youtube = {
          enable = true;
          config = "general (SIMPLE FAKE)";
        };
      };
    }
  else
    # INFO / zapret:
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
    {
      services = {
        zapret-discord-youtube.enable = mkForce false;

        zapret = {
          enable = true;

          sf_presets = {
            enable = true;
            preset = "renixos";
          };
        };
      };
    }
)
