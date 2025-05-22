{
  lib,
  config,
  ...
}:

with lib;

mkIf (itIs == "laptop") {
  hm.programs.waybar = {
    enable = true;

    style = import ./style.nix {
      inherit
        config
        ;
    };

    settings = import ./settings.nix {
      inherit
        config
        ;
    };
  };
}
