{
  pkgs,
  lib,
  ...
}:

with lib;
# INFO: use bluetui or bluetoothctl

mkIf (mac "pcRyazenka" || mac "thinkpadT14") {
  persist.dirs = [ "/var/lib/bluetooth" ];

  environment = {
    systemPackages = [ pkgs.bluetui ];

    shellAliases.blt = "bluetui";
  };

  hardware.bluetooth = {
    enable = true;

    powerOnBoot = true;

    settings = {
      General = {
        Experimental = true;
        Enable = "Source,Sink,Media,Socket";
      };

      LE = {
        MinConnectionInterval = 7;
        MaxConnectionInterval = 9;
        ConnectionLatency = 0;
      };
    };
  };
}
