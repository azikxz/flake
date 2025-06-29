{
  lib,
  ...
}:

with lib;

mkIf (machine == "thinkpadT14") {
  services.upower.enable = true;

  powerManagement = {
    enable = true;
    powertop.enable = true;
  };
}
