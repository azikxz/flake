{ pkgs }:

pkgs.stdenv.mkDerivation rec {
  pname = "obsidian-prettier";
  version = "0.1.1";

  mainJs = pkgs.fetchurl {
    url = "https://github.com/hipstersmoothie/obsidian-plugin-prettier/releases/download/${version}/main.js";
    sha256 = "sha256-D/RdfQFk8n5nXMLBXZE6bHih670BVJ2Ct4GbSWtPoz0=";
  };

  manifest = pkgs.fetchurl {
    url = "https://github.com/hipstersmoothie/obsidian-plugin-prettier/releases/download/${version}/manifest.json";
    sha256 = "sha256-4UvIbPm+YA73yVDlPvq4nI0gehY+PNPQcw9VFfnyc6s=";
  };

  buildInputs = [ pkgs.nodePackages_latest.prettier ];
  phases = [ "installPhase" ];

  installPhase = ''
    mkdir -p $out
    cp $mainJs $out/main.js
    cp $manifest $out/manifest.json
  '';
}
