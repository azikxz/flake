{
  pkgs,
  lib,
  ...
}:

with lib;

mkIf (mac "thinkpadT14") {
  hmPackages = with pkgs; [
    imagemagick
    jpegoptim
    lutgen
    optipng
  ];
}
