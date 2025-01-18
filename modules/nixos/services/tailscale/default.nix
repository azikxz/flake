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
    services.tailscale = True // {
      useRoutingFeatures = "both";
    };
  };
}
