{
  lib,
  ...
}:

with lib;

mkIf (machine == "thinkpadT14") {
  systemd.services.disableMic = {
    description = "Disable microphone light (turned on by default)";

    script = ''
      echo 0 > /sys/class/leds/platform\:\:micmute/brightness;
    '';

    serviceConfig.Type = "oneshot";
    wantedBy = [ "multi-user.target" ];
  };
}
