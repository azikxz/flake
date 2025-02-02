{
  x,
  lib,
  config,
  ...
}:
with lib;
with x;
let
  cfg = config.module.misc.protonmail;
in
{
  options = {
    module.misc.protonmail = {
      enable = mkBool false;
    };
  };

  config = mkIf cfg.enable { services.protonmail-bridge = on // { }; };
}
