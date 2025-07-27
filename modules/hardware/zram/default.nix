{
  lib,
  ...
}:

with lib;
# INFO:
# zram0       253:0    0  31.3G  0 disk [SWAP]
# fuck....

mkIf (mac' "isoXtended") {
  zramSwap = {
    enable = true;

    priority = 1000;

    algorithm = "zstd";

    swapDevices = 1;

    memoryPercent = 100;
  };
}
