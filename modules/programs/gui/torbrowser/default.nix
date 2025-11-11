{
  pkgs,
  lib,
  ...
}:

with lib;
# INFO:
# ff based browser with tor

mkIf false {
  hmPackages = [ pkgs.tor-browser ];
}
