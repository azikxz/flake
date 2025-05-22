{
  lib,
  ...
}:

with lib;

mkIf (itIs == "desktop" || itIs == "laptop") {
  hm.programs.fastfetch = {
    enable = true;

    settings = import ./settings.nix;
  };
}
