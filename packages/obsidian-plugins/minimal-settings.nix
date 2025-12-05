{
  pkgs,
  lib,
}:

pkgs.stdenv.mkDerivation rec {
  pname = "obsidian-minimal-settings";
  version = "8.1.1";

  mainJs = pkgs.fetchurl {
    url = "https://github.com/kepano/obsidian-minimal-settings/releases/download/${version}/main.js";
    sha256 = "sha256-oJL2Y0LrRt2T2W/9dcncXk85jYVHxB+lGzj57bWfTfY=";
  };

  manifest = pkgs.fetchurl {
    url = "https://github.com/kepano/obsidian-minimal-settings/releases/download/${version}/manifest.json";
    sha256 = "sha256-SKls4ezs64L4J3UZeJodDVJstAlpRQVm3A87eUf5zoI=";
  };

  phases = [ "installPhase" ];

  installPhase = ''
    mkdir -p $out
    cp $mainJs $out/main.js
    cp $manifest $out/manifest.json
  '';

  meta = {
    description = "Settings plugin to control colors and fonts in Minimal Theme";
    homepage = "https://github.com/kepano/obsidian-minimal-settings";
    license = lib.licenses.mit;
  };
}
