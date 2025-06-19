{
  pkgs,
  lib,
  ...
}:

with lib;

mkIf false {
  environment.systemPackages = with pkgs; [
    wine-tkg-ntsync
    winetricks
  ];
}
