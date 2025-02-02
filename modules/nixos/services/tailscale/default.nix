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
      enable = mkBool false;
    };
  };

  config = mkIf cfg.enable {
    services.tailscale = on // {
      useRoutingFeatures = "both";
    };
  };
}
