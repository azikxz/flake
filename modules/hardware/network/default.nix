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
      "46.226.165.53"
      "8.8.8.8"
      "1.1.1.1"
      "dns.comss.one"
    ];

    # hosts = import ./hosts.nix;
    extraHosts = builtins.readFile ./hosts;
  };

  programs.nm-applet = {
    enable = true;
    indicator = true;
  };
}
