{
  pkgs,
  lib,
  ...
}:

with lib;

mkIf false {
  persist.user.dirs = [ ".wine" ];

  environment.systemPackages = with pkgs; [
    gaming.wine-tkg-ntsync
    winetricks
  ];
}
