{
  lib,
  ...
}:

with lib;
# INFO:
# creates vpn(local network) for multiple devices
# configuring via
# https://login.tailscale.com/admin/machines

mkIf (mac "pcRyazenka" || mac "thinkpadT14") {
  persist.dirs = [ "/var/lib/tailscale" ];

  services.tailscale = {
    enable = true;
    openFirewall = true;

    useRoutingFeatures = "both";
  };
}
