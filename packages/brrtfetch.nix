{
  pkgs,
  lib,
}:

pkgs.stdenv.mkDerivation {
  pname = "brrtfetch";
  version = "git";

  src = pkgs.fetchFromGitHub {
    owner = "ferrebarrat";
    repo = "brrtfetch";
    rev = "ebe8634c8ec5340f7dde448bfb8d66d48428adab";
    hash = "sha256-CV9UMubrpMkNjYi+ZXuQ3Qc15+fh31CbkxkZD0BZP1E=";
  };

  nativeBuildInputs = [ pkgs.go ];

  buildPhase = ''
    export GOCACHE=$TMPDIR/go-cache
    go build -o brrtfetch ./go/main.go
  '';

  installPhase = ''
    mkdir -p $out/bin
    cp brrtfetch $out/bin/
  '';

  meta = {
    description = "Render animated ASCII art from a GIF for your sysinfo fetcher of choice";
    homepage = "https://github.com/ferrebarrat/brrtfetch";
    license = lib.licenses.mit;
    platforms = lib.platforms.all;
    maintainers = with lib.maintainers; [ azikx ];
    mainProgram = "brrtfetch";
  };
}
