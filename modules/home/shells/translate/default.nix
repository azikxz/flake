{
  lib,
  config,
  ...
}:

with lib;
with x;
let
  cfg = config.module.shells.translate;
in

{
  options = {
    module.shells.translate = {
      enable = mkBool false;
    };
  };

  config = mkIf cfg.enable {
    programs.translate-shell = on // {
      settings = {
        engine = "google";
        brief = true;
        show-original = false;
        hl = "en";
        tl = [
          "ru"
          "en"
          "jpn"
        ];
      } // import ./theme.nix;
    };
  };
}
