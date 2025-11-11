{
  lib,
  ...
}:

with lib;
# INFO:
# for control lights my sapphire 6700xt

mkIf (mac "pcRyazenka") {
  services.hardware.openrgb = {
    enable = true;
  };
}
