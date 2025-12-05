{
  pkgs,
  lib,
}:

pkgs.stdenv.mkDerivation rec {
  pname = "obsidian-prettier";
  version = "2.0.2";

  mainJs = pkgs.fetchurl {
    url = "https://github.com/GoodbyeNJN/obsidian-plugin-prettier/releases/download/${version}/main.js";
    sha256 = "sha256-lZ0RUB3e62bohMsfi3MDm5E0cJ2GBEkn5yb4ACaN2c0=";
  };

  manifest = pkgs.fetchurl {
    url = "https://github.com/GoodbyeNJN/obsidian-plugin-prettier/releases/download/${version}/manifest.json";
    sha256 = "sha256-SdPAWew2BcmMJTSHLkG4ibg4N6venVn5BDdSjCgQb8s=";
  };

  stylesCss = pkgs.fetchurl {
    url = "https://github.com/GoodbyeNJN/obsidian-plugin-prettier/releases/download/${version}/styles.css";
    sha256 = "sha256-sk49rmW1WyMPiw31ccSIBpouAt4Xe/yOvmwa0RSunm8=";
  };

  buildInputs = [ pkgs.nodePackages_latest.prettier ];
  phases = [ "installPhase" ];

  installPhase = ''
    mkdir -p $out
    cp $mainJs $out/main.js
    cp $manifest $out/manifest.json
    cp $stylesCss $out/styles.css
  '';

  meta = {
    description = "This is an Obsidian plugin that uses Prettier to format notes.";
    homepage = "https://github.com/GoodbyeNJN/obsidian-plugin-prettier";
    license = lib.licenses.mit;
  };
}
