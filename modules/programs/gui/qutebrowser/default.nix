{
  pkgs,
  lib,
  config,
  ...
}:

with lib;
# WARN: !!!!!!!
# VERY VERY UNSTABLE BROWSER

mkIf (mac "pcRyazenka" || mac "thinkpadT14") {
  persist.user.dirs = [ ".local/share/qutebrowser" ];

  environment.systemPackages = with pkgs.python312Packages; [
    adblock
    requests
  ];

  hm = {
    imports = [ ./whlist.nix ];

    programs.qutebrowser =
      {
        enable = true;
        package = pkgs.qutebrowser;
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
