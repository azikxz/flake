{
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
    hostName = system.hostName;

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
      "1.0.0.1"
      "1.1.1.1"
      "8.8.4.4"
      "8.8.8.8"
    ];

    extraHosts = readFile ./hosts;
  };

  programs.nm-applet = {
    enable = true;
    indicator = true;
  };
}
