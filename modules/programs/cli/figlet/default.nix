{
  pkgs,
  lib,
  ...
}:

with lib;

mkIf (itIs != "desktop" || itIs != "laptop") {
  hm = with pkgs; {
    home.packages = [ figlet ];

    xdg.configFile =
      let
        mk =
          name: sha256:
          fetchurl {
            url = "http://www.figlet.org/fonts/${name}.flf";
            inherit sha256;
          };
      in
      {
        "figlet/doom.flf".source = mk "doom" "sha256-PY/pljUmMp/51UFKl7D0fjqFLS8oimk/KThzD1ojDnU=";
        "figlet/epic.flf".source = mk "epic" "sha256-fzh5bNy8dGtCumgEmnSxNZ+67ndr2Q/1saKoW3W/kiY=";
        "figlet/small.flf".source = mk "small" "sha256-YybYpxjLV2idXqqY0wG5KX729jACeWNbkBUyovPWqt8=";
      };
  };
}
