{
  lib,
  ...
}:

with lib;

mkIf (machine == "pcRyazenka" || machine == "thinkpadT14") {
  services = {
    dbus.implementation = "broker";

    gvfs.enable = true;

    udisks2 = {
      enable = true;

      mountOnMedia = true;
    };
  };
}
