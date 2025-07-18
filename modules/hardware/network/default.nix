{
  lib,
  ...
}:

with lib;

{
  persist.dirs = [
    "/etc/NetworkManager/system-connections"
    "/var/lib/NetworkManager"
    "/var/lib/iwd"
  ];

  networking = rec {
    hostName = system.hostName;

    useDHCP = mkDefault true;

    networkmanager = {
      enable = true;

      dns = mkForce "none";

      wifi = {
        powersave = true;
        macAddress = "random";
        backend = "iwd";
      };

      insertNameservers = nameservers;
    };

    nameservers = [
      "1.1.1.1"
      "8.8.8.8"
    ];

    # hosts = import ./hosts.nix;
    extraHosts = builtins.readFile ./hosts;
  };

  programs.nm-applet = {
    enable = true;
    indicator = true;
  };
}
