{ pkgs }:

# ntsync

(pkgs.proton-ge-bin.overrideAttrs rec {
  pname = "proton-em";
  version = "10.0-24";

  src = pkgs.fetchzip {
    url = "https://github.com/Etaash-mathamsetty/Proton/releases/download/EM-${version}/proton-EM-${version}.tar.xz";
    sha256 = "sha256-fgE/J88LzIE/nLTcpaiUAvBvwtAe+m1E0JW+Eq9W2a0=";
  };
}).override
  { steamDisplayName = "Proton-EM"; }
