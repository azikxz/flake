{
  pkgs,
  lib,
  ...
}:

with lib;

mkIf (mac "pcRyazenka" || mac "thinkpadT14") {
  environment.systemPackages = [ pkgs.blender ];
}
