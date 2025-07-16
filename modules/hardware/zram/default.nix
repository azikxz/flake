{
  lib,
  ...
}:

with lib;

mkIf (mac' "isoXtended") {
  zramSwap = {
    enable = true;

    priority = 1000;

    algorithm = "zstd";

    swapDevices = 1;

    memoryPercent = 100;
  };
}
