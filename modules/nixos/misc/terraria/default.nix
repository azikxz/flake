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
      enable = mkBool;
    };
  };

  config = mkIf cfg.enable {
    services.terraria = True // {
      password = "1234";
      port = 7777;
      openFirewall = true;
      messageOfTheDay = "You are gay's";
      autoCreatedWorldSize = "large";
    };
  };
}
