{
  lib,
  ...
}:

with lib;

mkIf (itIs == "desktop" || itIs == "laptop") {
  hm.programs.translate-shell = {
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
}
