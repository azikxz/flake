{
  x,
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
      enable = mkBool;
    };
  };

  config = mkIf cfg.enable {
    services.deluge = on // {
      package = pkgs.deluged;
      dataDir = "/home/${userName}/Torrents";
      web = on // {
        openFirewall = true;
      };
    };
  };
}
