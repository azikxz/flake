{
  pkgs,
  lib,
}:

pkgs.stdenv.mkDerivation {
  pname = "cwalk";
  version = "git";

  src = pkgs.fetchFromGitHub {
    owner = "ashish0kumar";
    repo = "cwalk";
    rev = "8a5c0b5e9a5135ab6b3df8d25b75a21ff2c43c05";
    hash = "sha256-r69mK1N2KUVoUHE/JiYPLVolsltJ+Smt0uK4h5AX9pY=";
  };

  buildInputs = [ pkgs.ncurses ];

  buildPhase = ''
    gcc cwalk.c -lncurses -o cwalk
  '';

  installPhase = ''
    install -Dm755 cwalk -t $out/bin
  '';

  meta = {
    description = "pipes in terminal yeee";
    homepage = "https://gist.github.com/unazikx/261536eed5cefe385fa1a0b0eed7b2c2";
    license = lib.licenses.wtfpl;
    platforms = [ "x86_64-linux" ];
    maintainers = with lib.maintainers; [ unazikx ];
    mainProgram = "hasher";
  };
}
