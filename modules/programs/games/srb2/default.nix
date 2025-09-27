{
  pkgs,
  lib,
  ...
}:

with lib;

mkIf (mac "thinkpadT14") {
  persist.user.dirs = [ ".srb2" ];

  environment.systemPackages = [ pkgs.srb2 ];
}
