{
  lib,
  ...
}:

with lib;

mkIf (machine == "pcRyazenka") {
  services.hardware.openrgb = {
    enable = true;
  };
}
