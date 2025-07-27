{
  lib,
  ...
}:

with lib;
# INFO:
#
# > tr "FUCK NIXOS"
#     Черт, Никсос
#     FUCK NIXOS

mkIf (mac "pcRyazenka" || mac "thinkpadT14") {
  hm = {
    home.shellAliases.tr = "trans --brief";

    programs.translate-shell = {
      enable = true;

      settings = {
        engine = "google";

        brief = true;
        show-original = false;

        hl = "en";
        tl = [
          "ru"
          "en"
        ];
      } // import ./theme.nix;
    };
  };
}
