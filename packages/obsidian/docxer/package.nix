{ pkgs }:

pkgs.stdenv.mkDerivation rec {
  pname = "obsidian-docxer";
  version = "2.2.2";

  mainJs = pkgs.fetchurl {
    url = "https://github.com/Developer-Mike/obsidian-docxer/releases/download/${version}/main.js";
    sha256 = "sha256-xqeqWlomzRjdo18XYVGDnLWAuUvM3teApOASq07R5l0=";
  };

  manifest = pkgs.fetchurl {
    url = "https://github.com/Developer-Mike/obsidian-docxer/releases/download/${version}/manifest.json";
    sha256 = "sha256-JMv1JN0zhI+OD010uNhc+CjWW1JfXvHMlYxdWPw47fo=";
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
