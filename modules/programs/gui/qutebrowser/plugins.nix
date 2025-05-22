{
  pkgs,
  ...
}:

let
  inherit (pkgs)
    fetchurl
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
]
