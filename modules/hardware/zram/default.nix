{
  lib,
  ...
}:

with lib;

mkIf (mac' "isoXtended" || mac' "thinkpadT14") {
  zramSwap = {
    enable = true;

    priority = 1000;

    algorithm = "zstd";

    swapDevices = 1;

    memoryPercent = 100;
  };
}
