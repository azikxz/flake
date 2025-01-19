{
  x,
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
      zone = mkOpt.str;
    };
  };

  config =
    let
      ON = if cfg.zone != null then on else off;
    in
    {
      time.timeZone = cfg.zone; # TIME
      services.chrony = ON; # SYNC TIME
      i18n.defaultLocale = "en_US.UTF-8";
    };
}
