{
  pkgs,
  lib,
  ...
}:

with lib;

mkIf (machine == "thinkpadT14") {
  environment.systemPackages = with pkgs; [
    imagemagick
    jpegoptim
    lutgen
    optipng
  ];
}
