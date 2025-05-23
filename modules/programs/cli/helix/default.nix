{
  pkgs,
  lib,
  config,
  ...
}:

with lib;

mkIf (itIs == "desktop" || itIs == "laptop") {
  hm.programs.helix = {
    enable = true;

    defaultEditor = true;

    settings = import ./settings.nix // {
      keys = import ./binds.nix;
    };

    languages = import ./languages.nix {
      inherit
        pkgs
        lib
        ;
    };

    themes = import ./theme.nix {
      inherit
        lib
        config
        ;
    };
  };
}
