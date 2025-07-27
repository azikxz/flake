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

      dns = "systemd-resolved";

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

    # hosts = import ./hosts.nix;
    extraHosts = builtins.readFile ./hosts;

    resolvconf.dnsSingleRequest = true;
  };

  services.resolved.enable = true;

  programs.nm-applet = {
    enable = true;
    indicator = true;
  };
}
