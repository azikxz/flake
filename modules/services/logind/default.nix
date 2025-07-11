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
    ] (n: "hybrid-sleep"))
    // {
      powerKeyLongPress = "reboot";
      powerKey = "poweroff";
    };
}
