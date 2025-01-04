{
  pkgs,
  config,
  ...
}:
{
  programs.qutebrowser.greasemonkey =
    with config.lib.stylix.colors;
    let
      inherit (pkgs) fetchurl writeText;
    in
    [
      (fetchurl {
        url = "https://raw.githubusercontent.com/afreakk/greasemonkeyscripts/refs/heads/master/youtube_sponsorblock.js";
        sha256 = "sha256-nwNade1oHP+w5LGUPJSgAX1+nQZli4Rhe8FFUoF5mLE=";
      })
      (fetchurl {
        url = "https://raw.githubusercontent.com/afreakk/greasemonkeyscripts/refs/heads/master/youtube_adblock.js";
        sha256 = "sha256-AyD9VoLJbKPfqmDEwFIEBMl//EIV/FYnZ1+ona+VU9c=";
      })
      (writeText "darkreader.js" ''
        // ==UserScript==
        // @name          Dark Reader (Unofficial)
        // @icon          https://darkreader.org/images/darkreader-icon-256x256.png
        // @namespace     DarkReader
        // @description	  Inverts the brightness of pages to reduce eye strain
        // @version       4.9.96
        // @author        https://github.com/darkreader/darkreader#contributors
        // @homepageURL   https://darkreader.org/ | https://github.com/darkreader/darkreader
        // @run-at        document-end
        // @grant         none
        // @include       http*
        // @require       https://cdn.jsdelivr.net/npm/darkreader/darkreader.min.js
        // @noframes
        // ==/UserScript==

        DarkReader.enable({
          darkSchemeBackgroundColor: "${base00}",
          darkSchemeTextColor: "${base05}",
        	brightness: 60,
        	contrast: 80,
        	sepia: 0
        });
      '')
      (writeText "darkmode.user.js" ''
        // ==UserScript==
        // @match *://*.google.com/maps/*
        // @match *://www.youtube.com/*
        // ==/UserScript==

        const meta = document.createElement('meta');
        meta.name = "color-scheme";
        meta.content = "dark light";
        document.head.appendChild(meta);
      '')
    ];
}
