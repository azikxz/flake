{
  pkgs,
  lib,
  ...
}:

with lib;

mkIf (itIs == "desktop" || itIs == "laptop") {
  hm.home.packages = with pkgs; [
    unrar
    unzip
    zip
  ];
}
