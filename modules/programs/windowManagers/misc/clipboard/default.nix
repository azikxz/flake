{
  lib,
  ...
}:

with lib;
# INFO:
# modern clipboard with tui

mkIf (mac' "isoXtended") {
  services.ringboard = {
    wayland.enable = true;
  };
}
