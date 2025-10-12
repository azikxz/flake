{ pkgs }:

pkgs.stdenv.mkDerivation rec {
  pname = "obsidian-docxer";
  version = "2.3.0";

  mainJs = pkgs.fetchurl {
    url = "https://github.com/Developer-Mike/obsidian-docxer/releases/download/${version}/main.js";
    sha256 = "sha256-wQsQZGJp+1acw67aXH2RKFSq2nSuSbWdIKjZDD3JJi8=";
  };

  manifest = pkgs.fetchurl {
    url = "https://github.com/Developer-Mike/obsidian-docxer/releases/download/${version}/manifest.json";
    sha256 = "sha256-lmBOQSOqEMRYOxOq7mhohTpWuvHnOVaePhDgxvtHmdk=";
  };

  styleCss = pkgs.fetchurl {
    url = "https://github.com/Developer-Mike/obsidian-docxer/releases/download/${version}/styles.css";
    sha256 = "sha256-QoLdHufeGORuQSr92wsLveY1IMJDgV732gXo2T3DtxY=";
  };

  phases = [ "installPhase" ];

  installPhase = ''
    mkdir -p $out
    cp $mainJs $out/main.js
    cp $manifest $out/manifest.json
    cp $styleCss $out/style.css
  '';
}
