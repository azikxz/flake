{
  pkgs,
  lib,
  ...
}:

with lib;

mkIf (mac "pcRyazenka" || mac "thinkpadT14") {
  persist.user.dirs = [ ".config/blender" ];

  hm.home.packages = [ pkgs.blender ];
}
