{
  lib,
  config,
  ...
}:

with lib;
with x;
let
  cfg = config.module.services.torrentstream;
in

{
  options = {
    module.services.torrentstream = {
      enable = mkBool false;
    };
  };

  config = mkIf cfg.enable {
    services.torrentstream = on // {
      port = 5082;
      address = "127.0.0.1";
      openFirewall = true;
    };
  };
}
