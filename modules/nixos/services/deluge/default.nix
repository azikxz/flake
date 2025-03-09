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
      group = "media";
      openFirewall = true;
      dataDir = "/media/deluga";
      declarative = true;
      authFile = pkgs.writeText "deluge-auth" ''
        pirate:yoho:10
        localclient:deluge:10
      '';
      web = on // {
        port = 8112;
        openFirewall = true;
      };
      config = {
        random_port = false;
      };
    };
  };
}
