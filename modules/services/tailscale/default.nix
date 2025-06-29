{
  lib,
  ...
}:

with lib;

mkIf (machine == "pcRyazenka" || machine == "thinkpadT14") {
  services.tailscale = {
    enable = true;

    useRoutingFeatures = "both";

    openFirewall = true;
  };
}
