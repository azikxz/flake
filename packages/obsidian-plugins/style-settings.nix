{
  pkgs,
  lib,
}:

pkgs.stdenv.mkDerivation rec {
  pname = "obsidian-style-settings";
  version = "1.0.9";

  mainJs = pkgs.fetchurl {
    url = "https://github.com/mgmeyers/obsidian-style-settings/releases/download/${version}/main.js";
    sha256 = "sha256-GCirqs2rTFV4twWmJcWFswUS+O+tTHz8WhjnDMNVdGg=";
  };

  manifest = pkgs.fetchurl {
    url = "https://github.com/mgmeyers/obsidian-style-settings/releases/download/${version}/manifest.json";
    sha256 = "sha256-nP/cIM8qoTVIIOAFC2lLD5tXZEbj1dRKNq6LAYflv7g=";
  };

  stylesCss = pkgs.fetchurl {
    url = "https://github.com/mgmeyers/obsidian-style-settings/releases/download/${version}/styles.css";
    sha256 = "sha256-7nk30r5QZTqJzLMK5fBXKyNQfVt/EyjQBScaNjB1v9g=";
  };

  phases = [ "installPhase" ];

  installPhase = ''
    mkdir -p $out
    cp $mainJs $out/main.js
    cp $manifest $out/manifest.json
    cp $stylesCss $out/styles.css
  '';

  meta = {
    description = "A dynamic user interface for adjusting theme, plugin, and snippet CSS variables within Obsidian.";
    homepage = "https://github.com/mgmeyers/obsidian-style-settings";
    license = lib.licenses.gpl3;
  };
}
