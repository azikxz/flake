{
  lib,
  ...
}:

with lib;

mkIf (itIs == "desktop" || itIs == "laptop") {
  hm.programs.keepassxc = {
    enable = true;

    settings = import ./settings.nix {
      inherit
        lib
        ;
    };
  };
}
