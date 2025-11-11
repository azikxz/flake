{
  lib,
  ...
}:

with lib;
# INFO:
# optimization battery my thinkpadT14

mkIf (mac' "isoXtended") {
  services = {
    upower.enable = true;

    cpupower-gui = {
      enable = true;
    };
  };
}
// (optionalAttrs (mac "thinkpadT14") {
  powerManagement = {
    enable = true;
    powertop = {
      enable = true;
      settings = {
        battery = {
          governor = "powersave";
          turbo = "auto";
        };
        charger = {
          governor = "performance";
          turbo = "auto";
        };
      };
    };

    cpuFreqGovernor = "powersave";
  };
})
