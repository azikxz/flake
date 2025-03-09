{ pkgs }:

pkgs.stdenv.mkDerivation {
  name = "qbitHash";

  src = pkgs.fetchurl {
    url = "https://gist.githubusercontent.com/hastinbe/8b8d247f17481cfc262a98d661bc0fd5/raw/b4e443fc411ebc53f98ef3e12eac61eed49c510d/qbittorrent_hash.py";
    sha256 = "sha256-qmlBlDPmYJ0hDXpq0cX6Kp4mza+Xu/Tn908/nfZ8Xwk=";
  };

  buildInputs = [ pkgs.python3 ];

  unpackPhase = "true";
  installPhase = ''
    mkdir -p $out/bin;

    cp $src $out/bin/qbitHash

    chmod +x $out/bin/qbitHash
  '';
}
