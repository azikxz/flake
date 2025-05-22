{
  lib,
  ...
}:

with lib;

mkIf (itIs == "laptop") {
  services.upower.enable = true;

  powerManagement = {
    enable = true;
    powertop.enable = true;
  };
}
