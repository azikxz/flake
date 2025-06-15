{
  lib,
  ...
}:

with lib;

mkIf (itIs == "desktop") {
  virtualisation.podman = {
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

  networking.firewall.interfaces = {
    "podman+".allowedUDPPorts = [ 53 ];
  };
}
