{
  lib,
  ...
}:

with lib;

mkIf (mac "thinkpadT14") {
  services.upower.enable = true;

  powerManagement = {
    enable = true;
    powertop.enable = true;

    cpuFreqGovernor = "powersave";
  };
}
