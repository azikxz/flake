{ pkgs }:

pkgs.stdenv.mkDerivation {
  pname = "pokemon-colorscripts";

  src = pkgs.fetchFromGitLab {
    owner = "phoneybadger";
    repo = "pokemon-colorscripts";
    rev = "5802ff67520be2ff6117a0abc78a08501f6252ad";
    hash = "sha256-gKVmpHKt7S2XhSxLDzbIHTjJMoiIk69Fch202FZffqU=";
  };

  buildInputs = [ pkgs.python3 ];

  preBuild = ''
    patchShebangs ./install.sh
    patchShebangs ./pokemon-colorscripts.py

    substituteInPlace install.sh --replace "/usr/local" "$out"
  '';

  installPhase = ''
    mkdir -p $out/bin
    ./install.sh
  '';
}
