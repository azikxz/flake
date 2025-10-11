{
  pkgs,
  lib,
}:

pkgs.stdenv.mkDerivation {
  pname = "qbitHash";
  version = "git";

  src = pkgs.fetchurl {
    url = "https://gist.githubusercontent.com/hastinbe/8b8d247f17481cfc262a98d661bc0fd5/raw/b4e443fc411ebc53f98ef3e12eac61eed49c510d/qbittorrent_hash.py";
    sha256 = "sha256-qmlBlDPmYJ0hDXpq0cX6Kp4mza+Xu/Tn908/nfZ8Xwk=";
  };

  buildInputs = [ pkgs.python3 ];

  unpackPhase = "true";
  installPhase = ''
    mkdir -p $out/bin;
    cp $src $out/bin/qbit-hash
    chmod +x $out/bin/qbit-hash
  '';

  meta = {
    description = "Generate password for qbittorrent-nox";
    homepage = "https://gist.githubusercontent.com/hastinbe/8b8d247f17481cfc262a98d661bc0fd5";
    license = lib.licenses.gpl2;
    platforms = [ "x86_64-linux" ];
    maintainers = with lib.maintainers; [ azikx ];
    mainProgram = "qbit-hash";
  };
}
