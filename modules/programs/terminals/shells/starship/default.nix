{
  lib,
  config,
  ...
}:

with lib;
# INFO:
# best prompt

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
