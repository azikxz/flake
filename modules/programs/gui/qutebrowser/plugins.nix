{
  pkgs,
  ...
}:

with pkgs;
let
  rawGithub = "https://raw.githubusercontent.com/";
  gist' = "https://gist.githubusercontent.com/";

  azikx =
    gist' + "mctrxnv/482d955868b9fb625ad4d9339a1f24ed/raw/fc6a49e627ddbec1266b686c28dbd0c495275d2d/";
  afreakk = rawGithub + "afreakk/greasemonkeyscripts/refs/heads/master/";
in

[
  (fetchurl {
    url = afreakk + "youtube_sponsorblock.js";
    sha256 = "sha256-nwNade1oHP+w5LGUPJSgAX1+nQZli4Rhe8FFUoF5mLE=";
  })

  (fetchurl {
    url = afreakk + "youtube_adblock.js";
    sha256 = "sha256-AyD9VoLJbKPfqmDEwFIEBMl//EIV/FYnZ1+ona+VU9c=";
  })

  (fetchurl {
    url = azikx + "vot.user.js";
    sha256 = "sha256-TNG8qiEVXpFRC9ygwX+rGiqx0Szi8XF0NROpx8F8Cuk=";
  })

  (fetchurl {
    url = "https://gist.githubusercontent.com/ilyhalight/6eb5bb4dffc7ca9e3c57d6933e2452f3/raw/7ab38af2228d0bed13912e503bc8a9ee4b11828d/gm-addstyle-polyfill.js";
    sha256 = "sha256-C4NkK3NGDV0XehzoStm0lTUVT6XUMy4app+vAFpxY0E=";
  })

  (fetchurl {
    url = "https://cdnjs.cloudflare.com/ajax/libs/hls.js/1.5.18/hls.light.min.js";
    sha256 = "sha256-dpILMwhk+cf2QUUaNHLhs0moVtpkzO84coRuKFlBgvk=";
  })
]
