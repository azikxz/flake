{
  lib,
  ...
}:

with lib;
# INFO: tor

mkIf false {
  services = {
    tor = {
      enable = true;
      openFirewall = true;
      torsocks.enable = true;

      client = {
        enable = true;

        dns.enable = true;
      };

      relay = {
        enable = true;

        role = "relay";
      };

      settings = {
        Nickname = system.userName;
        ContactInfo = system.userName + "@nixos.com";

        MaxAdvertisedBandwidth = "100 MB";
        BandWidthRate = "50 MB";
        RelayBandwidthRate = "50 MB";
        RelayBandwidthBurst = "100 MB";

        CookieAuthentication = true;
        AvoidDiskWrites = 1;
        HardwareAccel = 1;
        SafeLogging = 1;
        NumCPUs = 3;

        ORPort = [ 443 ];
      };
    };

    snowflake-proxy = {
      enable = true;

      capacity = 10;
    };
  };
}
