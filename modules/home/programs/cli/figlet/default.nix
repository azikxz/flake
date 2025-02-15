{
  pkgs,
  lib,
  config,
  ...
}:

with lib;
with x;
let
  cfg = config.module.programs.cli.figlet;
in

{
  options = {
    module.programs.cli.figlet = {
      enable = mkBool false;
    };
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [ figlet ];
    xdg.configFile =
      let
        mk =
          name: hash:
          pkgs.fetchurl {
            url = "http://www.figlet.org/fonts/${name}";
            sha256 = toString hash;
          };
      in
      {
        "figlet/doom.flf".source = mk "doom.flf" "sha256-PY/pljUmMp/51UFKl7D0fjqFLS8oimk/KThzD1ojDnU=";
        "figlet/epic.flf".source = mk "epic.flf" "sha256-fzh5bNy8dGtCumgEmnSxNZ+67ndr2Q/1saKoW3W/kiY=";
        "figlet/small.flf".source = mk "small.flf" "sha256-YybYpxjLV2idXqqY0wG5KX729jACeWNbkBUyovPWqt8=";
      };
  };
}
