{
  pkgs,
  lib,
  ...
}:

with lib;
# INFO:
# modded games cool manager

mkIf (mac "pcRyazenka") {
  persist.user.dirs = [
    ".config/r2modman"
    ".config/r2modmanPlus-local"
  ];

  hmPackages = [ pkgs.r2modman ];
}
