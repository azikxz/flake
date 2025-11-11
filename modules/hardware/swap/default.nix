{
  lib,
  ...
}:

with lib;
# INFO:
# it brakes suspend on thinkpad

mkIf false {
  swapDevices = [
    {
      size = 1024 * 8;
      device = "/var/lib/swapfile";
    }
  ];
}
