{
  lib,
  ...
}:

with lib;
# INFO:
# use 'fprint-enroll' and 'sudo fprint-enroll'

mkIf (mac "pcRyazenka") {
  services.geoclue2.enable = true;
}
