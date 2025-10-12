{
  pkgs,
  lib,
  ...
}:

with lib;

mkIf (mac "pcRyazenka" || mac "thinkpadT14") {
  hm.home.packages = [ pkgs.blender ];
}
