{
  lib,
  options,
  ...
}:

with lib;

{
  persist.dirs = [ "/var/lib/chrony" ];

  services = {
    chrony.enable = true;
    # automatic-timezoned.enable = true;
  };

  time.timeZone = "Asia/Chita";

  networking.timeServers =
    let
      inherit (options.networking.timeServers)
        default
        ;
    in
    (
      default
      ++ [
        "0.ru.pool.ntp.org"
        "1.ru.pool.ntp.org"
        "2.ru.pool.ntp.org"
        "3.ru.pool.ntp.org"
      ]
    );

  i18n.defaultLocale = "en_US.UTF-8";
}
