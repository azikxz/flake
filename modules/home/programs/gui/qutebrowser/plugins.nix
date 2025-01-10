{
  pkgs,
  ...
}:
let
  inherit (pkgs) fetchurl;
in
{
  programs.qutebrowser.greasemonkey = [
    (fetchurl {
      url = "https://raw.githubusercontent.com/afreakk/greasemonkeyscripts/refs/heads/master/youtube_sponsorblock.js";
      sha256 = "sha256-nwNade1oHP+w5LGUPJSgAX1+nQZli4Rhe8FFUoF5mLE=";
    })
    (fetchurl {
      url = "https://raw.githubusercontent.com/afreakk/greasemonkeyscripts/refs/heads/master/youtube_adblock.js";
      sha256 = "sha256-AyD9VoLJbKPfqmDEwFIEBMl//EIV/FYnZ1+ona+VU9c=";
    })
    (fetchurl {
      url = "https://gist.githubusercontent.com/uwuwuwde/9c4f3d9bbb20dcf15bd801dcbf72159a/raw/4790935aaaa68f1709fdae2ba2f8c56d6c4b3939/untrack";
      sha256 = "sha256-CDdCPgcjW/4P+1+JU4HB8RvMFCMEXxSqbK0FRgk4KUg=";
    })
  ];
}
