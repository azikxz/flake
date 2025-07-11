{
  lib,
  ...
}:

with lib;

mkIf (mac "thinkpadT14") {
  swapDevices = [
    {
      size = 1024 * 8;
      device = "/var/lib/swapfile";
    }
  ];
}
