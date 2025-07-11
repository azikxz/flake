{
  lib,
  ...
}:

with lib;

mkIf (mac "pcRyazenka" || mac "thinkpadT14") {
  hm.programs.fastfetch = {
    enable = true;

    settings = import ./settings.nix;
  };
}
