{
  lib,
  config,
  ...
}:

with lib;
# INFO: best image viewer

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
