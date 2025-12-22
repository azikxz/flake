{
  pkgs,
  lib,
}:

pkgs.stdenv.mkDerivation {
  pname = "qbitHash";
  version = "git";

  src = pkgs.fetchurl {
    url = "https://gist.githubusercontent.com/azikxz/1ccd74944e0ebc84847829bb922204b4/raw/cf1a299a93cc53cbdbccb53d8a80d524bf99e461/qbit-hash.py";
    sha256 = "sha256-zSWRzYduB5BzayTrUhYu1+Etk8PnU8oNdOzGzoDwMKg=";
  };

  buildInputs = [ pkgs.python3 ];

  unpackPhase = "true";
  installPhase = ''
    install -Dm755 $src $out/bin/qbit-hash
  '';

  meta = {
    description = "Generate password for qbittorrent-nox";
    homepage = "https://gist.githubusercontent.com/hastinbe/8b8d247f17481cfc262a98d661bc0fd5";
    license = lib.licenses.gpl2;
    platforms = [ "x86_64-linux" ];
    maintainers = with lib.maintainers; [ azikxz ];
    mainProgram = "qbit-hash";
  };
}
