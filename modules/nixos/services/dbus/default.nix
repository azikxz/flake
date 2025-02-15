{
  lib,
  config,
  ...
}:

with lib;
with x;
let
  cfg = config.module.services.dbus;
in
{
  options = {
    module.services.dbus = {
      enable = mkBool false;
    };
  };

  config = mkIf cfg.enable {
    services = {
      dbus.implementation = "broker";
      udisks2 = on;
    };
  };
}
