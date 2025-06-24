{
  pkgs,
  lib,
  ...
}:

with lib;

mkIf (itIs == "desktop" || itIs == "laptop") {
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
    };
  };
}
