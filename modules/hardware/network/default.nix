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
      "84.21.189.133" # https://info.dns.malw.link
      "45.90.28.48" # https://my.nextdns.io
      "176.99.11.77" # https://xbox-dns.ru
    ];

    extraHosts = readFile ./hosts;
  };

  programs.nm-applet = {
    enable = true;
    indicator = true;
  };
}
