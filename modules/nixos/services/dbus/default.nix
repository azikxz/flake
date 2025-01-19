{
  x,
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
      enable = mkBool;
    };
  };

  config = mkIf cfg.enable {
    services = {
      dbus.implementation = "broker";
      udisks2 = on;
    };
  };
}
