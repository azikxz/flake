{
  lib,
  ...
}:

with lib;

{
  persist.dirs = [ "/var/lib/chrony" ];

  services = {
    chrony.enable = true;
    automatic-timezoned.enable = true;
  };

  i18n.defaultLocale = "en_US.UTF-8";
}
