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
      "1.1.1.1#cloudflare-dns.com"
      "8.8.8.8#dns.google"

      "83.220.169.155#dns.comss.one"

      # hetzner
      "185.12.64.1"
      "185.12.64.2"
      "2a01:4ff:ff00::add:1"
      "2a01:4ff:ff00::add:2"
    ];

    extraHosts = readFile ./hosts;
  };

  services.resolved = {
    enable = true;

    dnsovertls = "true";
    llmnr = "true";

    fallbackDns = [ "8.8.8.8#dns.google" ];
  };

  programs.nm-applet = {
    enable = true;
    indicator = true;
  };
}
