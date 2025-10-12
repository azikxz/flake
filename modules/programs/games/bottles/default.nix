{
  pkgs,
  lib,
  ...
}:

with lib;

mkIf false {
  persist.user.dirs = [ ".local/share/bottles" ];

  hmPackages = [
    (pkgs.bottles.override { removeWarningPopup = true; })
  ];
}
