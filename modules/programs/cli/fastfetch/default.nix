{
  lib,
  ...
}:

with lib;
# INFO: for another presets use
# fastfetch -c preset.json
#
# for getting all presets use:
# fastfetch --list-presets

mkIf (mac "pcRyazenka" || mac "thinkpadT14") {
  hm.programs.fastfetch = {
    enable = true;

    settings = import ./settings.nix;
  };
}
