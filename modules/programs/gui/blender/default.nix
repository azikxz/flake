{
  pkgs,
  lib,
  ...
}:

with lib;
# INFO:
# 3d modeling, montage and rendering

mkIf (mac "pcRyazenka" || mac "thinkpadT14") {
  persist.user.dirs = [ ".config/blender" ];

  hm.home.packages = [ pkgs.blender ];
}
