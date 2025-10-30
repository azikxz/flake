{
  inputs,
  lib,
  ...
}:

with lib;
# INFO: connect via nmtui

{
  persist.dirs = [
    "/etc/NetworkManager/system-connections"
    "/var/lib/NetworkManager"
    "/var/lib/iwd"
  ];

  networking = {
    inherit (system)
      hostName
      ;

    useDHCP = mkDefault true;

    networkmanager = {
      enable = true;

      wifi = {
        powersave = true;
        macAddress = "random";
        backend = "iwd";
      };
    };

    nameservers = [
      "8.8.8.8"
      "1.1.1.1"
    ];

    extraHosts = readFile ./hosts;
  };

  programs.nm-applet = {
    enable = true;
    indicator = true;
  };
}
