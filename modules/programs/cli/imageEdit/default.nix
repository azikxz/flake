{
  pkgs,
  lib,
  ...
}:

with lib;
# INFO:
# image editors

mkIf (mac "thinkpadT14") {
  hmPackages = with pkgs; [
    imagemagick
    jpegoptim
    lutgen
    optipng
  ];
}
