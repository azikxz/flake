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
      "1.1.1.1#cloudflare-dns.com"
      "8.8.8.8#dns.google"

      "94.140.14.14#dns.adguard-dns.com"
      "77.88.8.8#common.dot.dns.yandex.net"

      "83.220.169.155#dns.comss.one"
    ];
  };

  services.resolved = {
    enable = true;

    dnsovertls = "true";
    llmnr = "true";

    fallbackDns = [
      "8.8.8.8"
      "1.1.1.1"
    ];
  };

  programs.nm-applet = {
    enable = true;
    indicator = true;
  };
}
