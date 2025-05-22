{
  lib,
  ...
}:

with lib;

mkIf (itIs == "desktop" || itIs == "laptop") {
  services = {
    dbus.implementation = "broker";

    gvfs.enable = true;

    udisks2 = {
      enable = true;

      mountOnMedia = true;
    };
  };
}
