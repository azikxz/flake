{
  lib,
  ...
}:

with lib;
let
  dnsEnable = false;
in
# INFO:
# connect via nmtui
# also it contains dns resolving

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

    nameservers = mkIf (dnsEnable != true) [
      "1.1.1.1"
      "8.8.8.8"
    ];

    extraHosts = readFile ./hosts;
  };

  programs.nm-applet = {
    enable = true;
    indicator = true;
  };
}
// (optionalAttrs dnsEnable {
  networking.nameservers = [
    "1.1.1.1#cloudflare-dns.com"
    "8.8.8.8#dns.google"

    "83.220.169.155#dns.comss.one"

    # hetzner
    "185.12.64.1"
    "185.12.64.2"
    "2a01:4ff:ff00::add:1"
    "2a01:4ff:ff00::add:2"
  ];

  services.resolved = {
    enable = false;

    dnsovertls = "true";
    llmnr = "true";

    fallbackDns = [ "8.8.8.8#dns.google" ];
  };
})
