{
  lib,
  ...
}:

with lib;

mkIf (mac "pcRyazenka") {
  services.hardware.openrgb = {
    enable = true;
  };
}
