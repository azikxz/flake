{
  pkgs,
  lib,
  ...
}:

with lib;

mkIf (mac "pcRyazenka") {
  hmPackages = [ pkgs.popsicle ];
}
