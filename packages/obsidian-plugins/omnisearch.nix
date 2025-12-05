{
  pkgs,
  lib,
}:

pkgs.stdenv.mkDerivation rec {
  pname = "obsidian-omnisearch";
  version = "1.27.1";

  mainJs = pkgs.fetchurl {
    url = "https://github.com/scambier/obsidian-omnisearch/releases/download/${version}/main.js";
    sha256 = "sha256-Rse8Ew8uCHJquZhGgGfoWLcg7iJqI4BcffKvbJVUsQc=";
  };

  manifest = pkgs.fetchurl {
    url = "https://github.com/scambier/obsidian-omnisearch/releases/download/${version}/manifest.json";
    sha256 = "sha256-nRbJ3zhgV4sATaYySHcDyzmbsxCIJm8+NGmousfaVuo=";
  };

  stylesCss = pkgs.fetchurl {
    url = "https://github.com/scambier/obsidian-omnisearch/releases/download/${version}/styles.css";
    sha256 = "sha256-twt4bFGomeN2+5NpVPZVkIcJ/jy3RtmPG6H1FxhSris=";
  };

  phases = [ "installPhase" ];

  installPhase = ''
    mkdir -p $out
    cp $mainJs $out/main.js
    cp $manifest $out/manifest.json
    cp $stylesCss $out/styles.css
  '';

  meta = {
    description = "A search engine that 'just works' for Obsidian.";
    homepage = "https://github.com/scambier/obsidian-omnisearch";
    license = lib.licenses.gpl3;
  };
}
