{
  pkgs,
  lib,
  ...
}:

with lib;

mkIf false {
  environment.systemPackages = with pkgs; [
    gaming.wine-tkg-ntsync
    winetricks
  ];
}
