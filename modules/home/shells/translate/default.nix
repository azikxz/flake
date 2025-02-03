{
  x,
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
          "jpn"
        ];
        user-agent = "Mozilla/5.0 (X11; Linux x86_64; rv:33.0) Gecko/20100101 Firefox/33.0";
      } // import ./theme.nix;
    };
  };
}
