{
  pkgs,
  lib,
  ...
}:

with lib;
# INFO:
# burn images to usb

mkIf (mac "pcRyazenka") {
  hmPackages = [ pkgs.popsicle ];
}
