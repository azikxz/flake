{
  pkgs,
  ...
}:

let
  inherit (pkgs)
    fetchurl
    writeText
    ;
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

  (writeText "nixosWiki" ''
    // ==UserScript==
    // @name         NixOS old wiki -> new wiki redirect
    // @description  Redirects from old nixos.wiki to wiki.nixos.org
    // @version      0.0.1
    // @match        https://nixos.wiki/*
    // @run-at       document-start
    // @grant        none
    // ==/UserScript==

    (function() {
        function redirect() {
            const pathname = location.pathname;

            // Экранируем фигурные скобки, чтобы Nix не интерпретировал их
            location.href = "https://wiki.nixos.org" + pathname;
        }

        // Перенаправляем сразу при запуске
        redirect();

        // Слушаем изменения URL, если используется SPA
        window.addEventListener('urlchange', ({ url }) => {
            if (url.startsWith('https://nixos.wiki/')) {
                redirect();
            }
        });
    })();
  '')
]
