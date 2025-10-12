{
  pkgs,
  lib,
  ...
}:

with lib;

mkIf (mac "pcRyazenka") {
  persist.user.dirs = [
    ".config/r2modman"
    ".config/r2modmanPlus-local"
  ];

  hmPackages = [ pkgs.r2modman ];
}
