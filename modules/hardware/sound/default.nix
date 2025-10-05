{
  pkgs,
  lib,
  config,
  ...
}:

with lib;

mkIf (mac' "isoXtended") {
  environment = {
    systemPackages = [ pkgs.pulsemixer ];

    shellAliases.pmx = "pulsemixer";
  };

  security.rtkit.enable = true;

  services.pipewire = {
    enable = true;

    pulse = {
      enable = true;
    };

    wireplumber = {
      enable = true;
    };

    alsa = {
      enable = true;
      support32Bit = true;
    };

    lowLatency.enable = true;
  };

  musnix = {
    enable = true;
    rtcqs.enable = true;
  };
}
