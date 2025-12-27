{
  inputs,
  lib,
  ...
}:

with lib;
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

    nameservers = [
      "1.1.1.1"
      "8.8.8.8"
      "84.21.189.133"
      "83.220.169.155"
    ];

    extraHosts = readFile (inputs.dns-malw-link.outPath + "/hosts");
  };

  programs.nm-applet = {
    enable = true;
    indicator = true;
  };
}
