{ pkgs }:

pkgs.stdenv.mkDerivation rec {
  pname = "obsidian-image-toolkit";
  version = "1.4.2";

  mainJs = pkgs.fetchurl {
    url = "https://github.com/sissilab/obsidian-image-toolkit/releases/download/${version}/main.js";
    sha256 = "sha256-BBdIAy41S4Qg9iGZ5ygge6o4QYy5zGtQqH1qCQ49lI8=";
  };

  manifest = pkgs.fetchurl {
    url = "https://github.com/sissilab/obsidian-image-toolkit/releases/download/${version}/manifest.json";
    sha256 = "sha256-KJc3XPv5bJWBCHxZJKDccAhOghW6EnnaTECwnJ5+Oh0=";
  };

  style = pkgs.fetchurl {
    url = "https://github.com/sissilab/obsidian-image-toolkit/releases/download/${version}/styles.css";
    sha256 = "sha256-YzFBXNRKij+yBTfNF/VU7eVU6oGwK7gIJZ1ZkG7W+lk=";
  };

  phases = [ "installPhase" ];

  installPhase = ''
    mkdir -p $out
    cp $mainJs $out/main.js
    cp $manifest $out/manifest.json
    cp $style $out/style.css
  '';
}
