{
  lib,
  config,
  ...
}:

with lib;

mkIf config.programs.fish.enable {
  hm.programs.starship = {
    enable = true;
    enableTransience = true;

    settings = import ./settings.nix {
      inherit
        lib
        ;
    };
  };
}
