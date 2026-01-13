{
  lib,
  ...
}:

with lib;
# INFO:
# good calendar?

mkIf (mac "pcRyazenka") {
  hm.programs = {
    khal = {
      enable = true;

      locale.weeknumbers = "left";
    };

    qcal.enable = true;
  };
}
