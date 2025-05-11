{
  pkgs,
  lib,
  config,
  ...
}:

with lib;
with x;
let
  cfg = config.module.programs.gui.qutebrowser;
in

{
  options = {
    module.programs.gui.qutebrowser = {
      enable = mkBool false;
    };
  };

  imports = [ ./whlist.nix ];
  config = mkIf cfg.enable {
    impermanence.dirs = [ ".local/share/qutebrowser" ];
    home.packages = with pkgs.python312Packages; [
      adblock
      requests
    ];
    programs.qutebrowser =
      on
      // import ./settings.nix {
        inherit
          lib
          config
          ;
      }
      // {
        searchEngines = {
          DEFAULT = "https://www.google.com/search?q={}";
        };
        keyBindings = import ./binds.nix {
          inherit
            pkgs
            lib
            ;
        };
        greasemonkey = import ./plugins.nix {
          inherit
            pkgs
            ;
        };
      };
  };
}
