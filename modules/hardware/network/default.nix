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
      "64.188.98.242" # dns.malw.link
    ];

    # hosts = import ./hosts.nix;
    extraHosts = builtins.readFile ./hosts;

    firewall = {
      allowedUDPPorts = [ 5029 ];
    };
  };

  programs.nm-applet = {
    enable = true;
    indicator = true;
  };
}
