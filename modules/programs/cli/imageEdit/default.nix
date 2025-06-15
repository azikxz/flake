{
  pkgs,
  lib,
  ...
}:

with lib;

mkIf (itIs != "desktop") {
  environment.systemPackages = with pkgs; [
    imagemagick
    jpegoptim
    lutgen
    optipng
  ];
}
