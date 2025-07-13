{ pkgs }:

(pkgs.proton-ge-bin.overrideAttrs rec {
  pname = "proton-umu";
  version = "9.0-4e";

  src = pkgs.fetchzip {
    url = "https://github.com/Open-Wine-Components/umu-proton/releases/download/UMU-Proton-${version}/UMU-Proton-${version}.tar.gz";
    sha256 = "sha256-1TYX073YlPTVyP1D6Cf/+7zbtJv0c9f7O+JhjdRx6/M=";
  };

}).override
  { steamDisplayName = "Proton-UMU"; }
