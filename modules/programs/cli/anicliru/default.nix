{
  pkgs,
  lib,
  ...
}:

with lib;

mkIf (itIs == "desktop" || itsIs == "laptop") {
  hm.home.packages = [ pkgs.anicliru ];
}
