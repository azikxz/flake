{
  pkgs,
  lib,
  ...
}:

with lib;

mkIf false {
  persist.user.dirs = [ ".local/share/bottles" ];

  environment.systemPackages = with pkgs; [
    (bottles.override { removeWarningPopup = true; })
  ];
}
