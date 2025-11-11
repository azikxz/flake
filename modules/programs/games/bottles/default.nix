{
  pkgs,
  lib,
  ...
}:

with lib;
# INFO:
# bullshit

mkIf false {
  persist.user.dirs = [ ".local/share/bottles" ];

  hmPackages = [
    (pkgs.bottles.override { removeWarningPopup = true; })
  ];
}
