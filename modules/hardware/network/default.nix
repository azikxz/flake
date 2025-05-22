{
  lib,
  ...
}:

with lib;

{
  persist.dirs = [
    "/var/lib/NetworkManager"
    "/var/lib/iwd"
  ];

  networking = {
    hostName = system.hostName;
    useDHCP = mkDefault true;

    networkmanager = {
      enable = true;

      dns = "systemd-resolved";

      ethernet = {
        macAddress = "random";
      };

      wifi = {
        powersave = true;
        macAddress = "random";
        backend = "iwd";
      };
    };

    nameservers = [
      "::1"
      "127.0.0.1"
      "100.100.100.100"
      "1.0.0.1"
      "1.1.1.1"
      "8.8.8.8"
    ];

    resolvconf.dnsSingleRequest = true;

    hosts = import ./hosts.nix;

    firewall = {
      allowedUDPPorts = [ 5029 ];
    };
  };

  services.resolved.enable = true;
}
