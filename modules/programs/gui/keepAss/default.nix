{
  lib,
  ...
}:

with lib;

mkIf (machine == "pcRyazenka" || machine == "thinkpadT14") {
  hm.programs.keepassxc = {
    enable = true;

    settings = import ./settings.nix;
  };
}
