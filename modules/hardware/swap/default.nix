{
  lib,
  ...
}:

with lib;

mkIf (machine == "thinkpadT14") {
  swapDevices = [
    {
      size = 1024 * 8;
      device = "/var/lib/swapfile";
    }
  ];
}
