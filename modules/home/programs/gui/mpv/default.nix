{
  pkgs,
  lib,
  config,
  ...
}:

with lib;
with x;
let
  theme = import ./theme.nix {
    inherit
      config
      lib
      ;
  };
  settings = import ./settings.nix {
    inherit
      pkgs
      lib
      ;
  };
  cfg = config.module.programs.gui.mpv;
in

{
  options = {
    module.programs.gui.mpv = {
      enable = mkBool false;
    };
  };

  config = mkIf cfg.enable {
    programs.mpv = on // {
      bindings = import ./bindings.nix;
      scripts = with pkgs.mpvScripts; [
        sponsorblock-minimal
        thumbnail
      ];
      scriptOpts = settings.script // theme.uosc;
      config = settings.config // theme.conf;
      extraInput = settings.extra;
    };
  };
}
