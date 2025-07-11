{
  lib,
  config,
  ...
}:

with lib;

mkIf (mac "pcRyazenka" || mac "thinkpadT14") {
  hm.programs.swayimg = {
    enable = true;

    settings = import ./settings.nix {
      inherit
        config
        ;
    };
  };
}
