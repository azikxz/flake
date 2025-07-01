{
  pkgs,
  lib,
  ...
}:

with lib;

mkIf (machine == "pcRyazenka" || machine == "thinkpadT14") {
  persist.dirs = [ "/var/lib/bluetooth" ];

  environment = {
    systemPackages = [ pkgs.bluetui ];

    shellAliases.pmx = "pulsemixer";
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
