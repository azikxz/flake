{ pkgs }:

# ntsync

(pkgs.proton-ge-bin.overrideAttrs rec {
  pname = "proton-moji";
  version = "10-4";

  src = pkgs.fetchzip {
    url = "https://github.com/telqor/proton-ge-custom/releases/download/GE-Proton${version}-Moji/GE-Proton${version}-Moji.tar.gz";
    sha256 = "sha256-9CYAQerKIRWPI6LzqWK4l9SkmbXHSQOoDiIzjaJB/2I=";
  };

}).override
  { steamDisplayName = "Proton-MOJI"; }
