{
  pkgs,
  ...
}:

with pkgs;
let
  afreakk = "https://raw.githubusercontent.com/afreakk/greasemonkeyscripts/refs/heads/master/";
in

[
  (writeText "youtubeTweaks.js" ''
    // ==UserScript==
    // @name    Userstyle (youtube.css)
    // @match        *://*.youtube.com/*
    // @exclude     *://music.youtube.com/*
    // ==/UserScript==
    GM_addStyle(`
      #country-code.ytd-topbar-logo-renderer { display: none; }
      yt-button-shape { display: none; }
      yt-button-renderer, ytd-button-renderer, ytd-toggle-button-renderer { display: none; }
    `)
  '')

  (fetchurl {
    url = afreakk + "youtube_sponsorblock.js";
    sha256 = "sha256-nwNade1oHP+w5LGUPJSgAX1+nQZli4Rhe8FFUoF5mLE=";
  })

  (fetchurl {
    url = afreakk + "youtube_adblock.js";
    sha256 = "sha256-AyD9VoLJbKPfqmDEwFIEBMl//EIV/FYnZ1+ona+VU9c=";
  })
]
