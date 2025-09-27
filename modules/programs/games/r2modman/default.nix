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

  environment.systemPackages = [ pkgs.r2modman ];
}
