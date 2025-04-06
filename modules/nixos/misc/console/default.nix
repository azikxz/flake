{
  pkgs,
  lib,
  config,
  ...
}:

with lib;
with x;
let
  cfg = config.module.misc.console;
in

{
  options = {
    module.misc.console = {
      enable = mkBool false;
    };
  };

  config = mkIf cfg.enable {
    console = on // {
      earlySetup = true;
      font = pkgs.terminus_font + "/share/consolefonts/ter-v16n.psf.gz";
      packages = [ pkgs.terminus_font ];
      keyMap = "us";
    };
  };
}
