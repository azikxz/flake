{
  pkgs,
  lib,
  config,
  ...
}:

with lib;

mkIf (mac "pcRyazenka" || mac "thinkpadT14") {
  programs.niri = {
    package = pkgs.niri-unstable;
  };

  hm.programs.niri = {
    enable = true;

    package = pkgs.niri-unstable;

    settings = {
      binds = import ./binds/main.nix {
        inherit
          lib
          config
          ;
      };
    }
    // import ./settings.nix {
      inherit
        pkgs
        lib
        config
        ;
    };
  };
}
