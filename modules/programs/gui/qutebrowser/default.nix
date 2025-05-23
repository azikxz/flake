{
  pkgs,
  lib,
  config,
  ...
}:

with lib;

mkIf (itIs == "desktop" || itIs == "laptop") {
  hm.imports = [ ./whlist.nix ];

  persist.user.dirs = [ ".local/share/qutebrowser" ];

  hm = {
    home.packages = with pkgs.python312Packages; [
      adblock
      requests
    ];

    programs.qutebrowser =
      {
        enable = true;
      }
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
