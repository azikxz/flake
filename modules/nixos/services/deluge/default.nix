{
  pkgs,
  lib,
  config,
  ...
}:

with lib;
with x;
let
  cfg = config.module.services.deluge;
in

{
  options = {
    module.services.deluge = {
      enable = mkBool false;
    };
  };

  config = mkIf cfg.enable {
    services.deluge = on // {
      package = pkgs.deluged;
      dataDir = "/home/${sys.userName}/Torrents";
      web = on // {
        openFirewall = true;
      };
    };
  };
}
