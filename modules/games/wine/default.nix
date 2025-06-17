{
  pkgs,
  lib,
  ...
}:

with lib;

mkIf (itIs == "desktop" || itIs == "laptop") {
  environment.systemPackages = with pkgs; [
    wine-tkg-ntsync
    winetricks
  ];
}
