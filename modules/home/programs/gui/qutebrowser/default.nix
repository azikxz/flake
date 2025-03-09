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
      quickmarks = mkAttrs.str { };
    };
  };

  imports = [
    ./rules.nix
    ./stylesheets.nix
  ];
  config = mkIf cfg.enable {
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
        searchEngines = import ./search.nix;
      };
  };
}
