{
  lib,
  ...
}:

with lib;
# INFO:
# lid switch, screen lock and unlock

mkIf (mac "thinkpadT14") {
  services.logind.settings.Login =
    (genAttrs [
      "HandleLidSwitchExternalPower"
      "HandleLidSwitchDocked"
    ] (n: "ignore"))
    // {
      "HandleLidSwitch" = "suspend";

      HandlePowerKeyLongPress = "reboot";
      HandlePowerKey = "poweroff";
    };
}
