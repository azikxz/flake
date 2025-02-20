{ pkgs }:

pkgs.stdenv.mkDerivation rec {
  name = "torrserver";
  version = "134";

  dontUnpack = true;
  nativeBuildInputs = [ pkgs.autoPatchelfHook ];

  src = pkgs.fetchurl {
    url = "https://github.com/YouROK/TorrServer/releases/download/MatriX.${version}/TorrServer-linux-amd64";
    sha256 = "sha256-WDygG9aGnD20nGxtG0t+T2KEwbJ+fZ0uRaCndirrsXI=";
  };

  installPhase = ''
    mkdir -p $out/bin
    cp $src $out/bin/torrserver
    chmod +x $out/bin/torrserver
  '';
}
