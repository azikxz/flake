{
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
      enable = mkBool false;
    };
  };

  config = mkIf cfg.enable {
    impermanence.dirs = [
      "/var/lib/NetworkManager"
      "/var/lib/iwd"
    ];
    networking = {
      hosts = import ./hosts.nix;
      resolvconf.dnsSingleRequest = true;
      networkmanager = on // {
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
      firewall = {
        allowedUDPPorts = [ 5029 ];
      };
    };
    services.resolved = on;
    systemd.services = {
      NetworkManager-wait-online = off;
      systemd-networkd-wait-online = mkForce off;
    };
  };
}
