{
  lib,
  config,
  ...
}:

with lib;

mkIf (itIs == "desktop" || itIs == "laptop") {
  hm.programs.swayimg = {
    enable = true;

    settings = import ./settings.nix {
      inherit
        config
        ;
    };
  };
}
