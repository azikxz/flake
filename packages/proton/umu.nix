{ pkgs }:

(pkgs.proton-ge-bin.overrideAttrs rec {
  pname = "proton-umu";
  version = "9.0-3.2";

  src = pkgs.fetchzip {
    url = "https://github.com/Open-Wine-Components/umu-proton/releases/download/UMU-Proton-${version}/UMU-Proton-${version}.tar.gz";
    sha256 = "sha256-tRot5HQCe1O7LFktIWpMfpTp+3f/HKOa9o6+N9XswLs=";
  };

}).override
  { steamDisplayName = "Proton-UMU"; }
