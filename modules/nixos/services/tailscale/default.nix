{
  x,
  lib,
  config,
  ...
}:
with lib;
with x;
let
  cfg = config.module.services.tailscale;
in
{
  options = {
    module.services.tailscale = {
      enable = mkBool;
    };
  };

  config = mkIf cfg.enable {
    services = {
      tailscale = True // {
        # OWN VPN NETWORK
        useRoutingFeatures = "both";
      };
    };
  };
}
