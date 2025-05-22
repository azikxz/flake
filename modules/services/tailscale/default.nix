{
  lib,
  ...
}:

with lib;

mkIf (itIs == "desktop" || itIs == "laptop") {
  services.tailscale = {
    enable = true;

    useRoutingFeatures = "both";

    openFirewall = true;
  };
}
