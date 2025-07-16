{
  lib,
  ...
}:

with lib;

mkIf false {
  swapDevices = [
    {
      size = 1024 * 8;
      device = "/var/lib/swapfile";
    }
  ];
}
