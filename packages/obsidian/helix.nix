{ pkgs }:

pkgs.stdenv.mkDerivation rec {
  pname = "obsidian-helix";
  version = "0.1.10";

  mainJs = pkgs.fetchurl {
    url = "https://github.com/Sinono3/obsidian-helix/releases/download/${version}/main.js";
    sha256 = "sha256-ulUwW8K/ArVQemsu3I+a2zE53q5OvwhfobZfrCsijfw=";
  };

  manifest = pkgs.fetchurl {
    url = "https://github.com/Sinono3/obsidian-helix/releases/download/${version}/manifest.json";
    sha256 = "sha256-vQVSfKJl4YGk7sG/6B3pKJk5c6w2fz96OGBfStdlc1U=";
  };

  phases = [ "installPhase" ];

  installPhase = ''
    mkdir -p $out
    cp $mainJs $out/main.js
    cp $manifest $out/manifest.json
  '';
}
