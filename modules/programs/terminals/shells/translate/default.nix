{
  lib,
  ...
}:

with lib;
# INFO:
#
# > tr "FUCK NIXOS"
#     Нахуй Никсос

mkIf (mac "pcRyazenka" || mac "thinkpadT14") {
  hm.programs.translate-shell = {
    enable = true;

    settings = {
      engine = "google";

      brief = true;
      show-original = false;

      hl = "en";
      tl = [ "ru" ];
    }
    // import ./theme.nix;
  };
}
