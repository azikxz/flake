{
  lib,
  ...
}:

with lib;
# INFO: lid switch, screen lock and unlock

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
