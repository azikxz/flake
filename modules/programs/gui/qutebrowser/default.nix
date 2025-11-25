{
  pkgs,
  lib,
  config,
  ...
}:

with lib;
# WARN: !!!!!!
# VERY VERY UNSTABLE BROWSER

mkIf (mac "pcRyazenka" || mac "thinkpadT14") {
  persist.user.dirs = [ ".local/share/qutebrowser" ];

  hmPackages = with pkgs.python312Packages; [
    adblock
    requests
  ];

  hm = {
    imports = [ ./whlist.nix ];

    programs.qutebrowser = {
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
        _4get = "https://4get.nadeko.net/web?s={}";
      };

      keyBindings = import ./binds.nix;

      greasemonkey = import ./plugins.nix {
        inherit
          pkgs
          ;
      };
    };

    xdg.mimeApps.associations.removed = genAttrs [
      "image/avif"
      "image/gif"
      "image/heif"
      "image/jpg"
      "image/jpeg"
      "image/jxl"
      "image/png"
      "image/bmp"
      "image/x-eps"
      "image/x-icns"
      "image/x-ico"
      "image/x-portable-bitmap"
      "image/x-portable-graymap"
      "image/x-portable-swayimgmap"
      "image/x-xbitmap"
      "image/x-xswayimgmap"
      "image/tiff"
      "image/x-psd"
      "image/x-webp"
      "image/webp"
      "image/x-tga"
      "image/svg+xml"
    ] (n: [ "org.qutebrowser.qutebrowser.desktop" ]);
  };

  hmMime = mkMime {
    "org.qutebrowser.qutebrowser.desktop" = [
      "text/html"
      "x-scheme-handler/http"
      "x-scheme-handler/https"
      "x-scheme-handler/chrome"
      "x-scheme-handler/about"
      "x-scheme-handler/unknown"
    ];
  };
}
