{
  pkgs,
  lib,
  config,
  ...
}:

with lib;

{
  hm.programs.niri = {
    enable = true;

    package = pkgs.niri-unstable;

    settings =
      {
        binds = import ./binds/main.nix {
          inherit
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
