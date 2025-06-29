{
  lib,
  ...
}:

with lib;

mkIf (machine == "pcRyazenka" || machine == "thinkpadT14") {
  hm.programs.fastfetch = {
    enable = true;

    settings = import ./settings.nix;
  };
}
