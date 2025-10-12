{
  pkgs,
  lib,
  ...
}:

with lib;

mkIf false {
  hmPackages = [ pkgs.tor-browser ];
}
