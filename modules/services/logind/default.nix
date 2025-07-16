{
  lib,
  ...
}:

with lib;

mkIf (mac "thinkpadT14") {
  services.logind =
    (genAttrs [
      "lidSwitchExternalPower"
      "lidSwitchDocked"
      "lidSwitch"
    ] (n: "ignore"))
    // {
      powerKeyLongPress = "reboot";
      powerKey = "poweroff";
    };
}
