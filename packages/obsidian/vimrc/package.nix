{ pkgs }:

pkgs.stdenv.mkDerivation rec {
  pname = "obsidian-vimrc";
  version = "0.10.2";

  mainJs = pkgs.fetchurl {
    url = "https://github.com/esm7/obsidian-vimrc-support/releases/download/${version}/main.js";
    sha256 = "sha256-aGNzThnu8lBeBUJQyoIbxTL21iceb1AXKx6KBHNObOI=";
  };

  manifest = pkgs.fetchurl {
    url = "https://github.com/esm7/obsidian-vimrc-support/releases/download/${version}/manifest.json";
    sha256 = "sha256-st5aS+ORuI69konjgVYtFJGlh5ef0Iu9pqf/Ub4n0FY=";
  };

  phases = [ "installPhase" ];

  installPhase = ''
    mkdir -p $out
    cp $mainJs $out/main.js
    cp $manifest $out/manifest.json
  '';
}
