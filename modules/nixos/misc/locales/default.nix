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
      enable = mkBool;
      zone = mkOpt.str;
    };
  };

  config = mkIf cfg.enable {
    time.timeZone = cfg.zone; # TIME
    services.chrony = True; # SYNC TIME
    i18n.defaultLocale = "en_US.UTF-8";
  };
}
