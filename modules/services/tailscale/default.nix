{
  lib,
  ...
}:

with lib;
# INFO: configuring via
# https://login.tailscale.com/admin/machines

mkIf (mac "pcRyazenka" || mac "thinkpadT14") {
  persist.dirs = [ "/var/lib/tailscale" ];

  services.tailscale = {
    enable = true;

    useRoutingFeatures = "both";

    openFirewall = true;
  };
}
