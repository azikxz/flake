{
  pkgs,
  lib,
}:

pkgs.stdenv.mkDerivation rec {
  pname = "obsidian-helix";
  version = "0.1.11";

  mainJs = pkgs.fetchurl {
    url = "https://github.com/Sinono3/obsidian-helix/releases/download/${version}/main.js";
    sha256 = "sha256-SYMmbBLzkB0qwMG3sX/1WXA6KCY029xUo0RaObK2334=";
  };

  manifest = pkgs.fetchurl {
    url = "https://github.com/Sinono3/obsidian-helix/releases/download/${version}/manifest.json";
    sha256 = "sha256-lK2T/IeNTV0RTaLK31amoVFlJMhXTUIKAJIccEMLPGw=";
  };

  phases = [ "installPhase" ];

  installPhase = ''
    mkdir -p $out
    cp $mainJs $out/main.js
    cp $manifest $out/manifest.json
  '';

  meta = {
    description = "Use Helix keybindings inside Obsidian.md.";
    homepage = "https://github.com/obsidian-helix/obsidian-helix";
    license = lib.licenses.mit;
  };
}
