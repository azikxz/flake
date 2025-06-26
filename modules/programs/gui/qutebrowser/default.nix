{
  pkgs,
  lib,
  config,
  ...
}:

with lib;

mkIf (itIs == "desktop" || itIs == "laptop") {
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
          _4get = "https://4get.nadeko.net/web?s={}";
          ddg = "https://html.duckduckgo.com/html/?q={}";
          gpt = "https://chatgpt.com/?q={}";
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
