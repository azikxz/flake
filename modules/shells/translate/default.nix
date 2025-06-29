{
  lib,
  ...
}:

with lib;

mkIf (machine == "pcRyazenka" || machine == "thinkpadT14") {
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
