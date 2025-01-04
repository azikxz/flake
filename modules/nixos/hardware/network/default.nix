{
  x,
  lib,
  config,
  ...
}:
with lib;
with x;
let
  cfg = config.module.hardware.network;
in
{
  options = {
    module.hardware.network = {
      enable = mkBool;
    };
  };

  config = mkIf cfg.enable {
    networking = {
      # FOR NETWORK
      resolvconf.dnsSingleRequest = true;
      networkmanager = True // {
        dns = "systemd-resolved";
        wifi = {
          powersave = true;
          macAddress = "random";
          backend = "iwd";
        };
      };
    };
    services = {
      resolved = True;
      pptpd = True;
    };
    systemd.services = {
      # IDK
      NetworkManager-wait-online = False;
      systemd-networkd-wait-online = mkForce False;
    };
  };
}
