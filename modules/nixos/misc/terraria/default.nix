{
  x,
  lib,
  config,
  ...
}:
with lib;
with x;
let
  cfg = config.module.misc.terraria;
in
{
  options = {
    module.misc.terraria = {
      enable = mkBool false;
    };
  };

  config = mkIf cfg.enable {
    services.terraria = on // {
      password = "1234";
      port = 7777;
      openFirewall = true;
      messageOfTheDay = "You are gay's";
      autoCreatedWorldSize = "large";
    };
  };
}
