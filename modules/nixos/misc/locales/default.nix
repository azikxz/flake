{
  lib,
  config,
  ...
}:

with lib;
with x;
let
  cfg = config.module.misc.locales;
in

{
  options = {
    module.misc.locales = {
      zone = mkNull.str null;
    };
  };

  config =
    let
      time = if x.sys.is == "iso" then null else cfg.zone;
    in
    {
      time.timeZone = time; # time
      services.chrony = on; # sync time
      i18n.defaultLocale = "en_US.UTF-8";
    };
}
