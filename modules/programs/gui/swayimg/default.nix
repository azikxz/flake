{
  lib,
  config,
  ...
}:

with lib;

mkIf (machine == "pcRyazenka" || machine == "thinkpadT14") {
  hm.programs.swayimg = {
    enable = true;

    settings = import ./settings.nix {
      inherit
        config
        ;
    };
  };
}
