{
  pkgs,
  lib,
  ...
}:

with lib;

mkIf (mac "thinkpadT14") {
  persist.user.dirs = [ ".srb2" ];

  hmPackages = [ pkgs.srb2 ];
}
