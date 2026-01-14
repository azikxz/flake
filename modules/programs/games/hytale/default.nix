{
  pkgs,
  lib,
  ...
}:

with lib;
# INFO:
# i waited 7 years...finally

mkIf (mac "pcRyazenka" || mac "thinkpadT14") {
  persist.user.dirs = [ ".local/share/hytale-launcher" ];

  hmPackages = [ pkgs.hytale ];
}
