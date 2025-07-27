{
  lib,
  ...
}:

with lib;
# INFO: base for pods

mkIf false {
  virtualisation = {
    spiceUSBRedirection.enable = true;

    podman = {
      enable = true;
      dockerCompat = true;

      autoPrune = {
        enable = true;
        flags = [
          "--all"
          "--volumes"
        ];
      };

      defaultNetwork.settings = {
        dns_enabled = true;
      };
    };
  };

  networking.firewall.interfaces = {
    "podman+".allowedUDPPorts = [ 53 ];
  };
}
