{
  lib,
  ...
}:

with lib;

mkIf (mac "pcRyazenka" || mac "thinkpadT14") {
  services = {
    dbus.implementation = "broker";

    gvfs.enable = true;

    udisks2 = {
      enable = true;

      mountOnMedia = true;
    };
  };
}
