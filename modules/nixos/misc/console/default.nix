{
  x,
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
      enable = mkBool;
    };
  };

  config = mkIf cfg.enable {
    console = True // {
      earlySetup = true;
      font = with pkgs; "${terminus_font}/share/consolefonts/ter-v16n.psf.gz";
      packages = [ terminus_font ];
      keyMap = "us";
    };
  };
}
