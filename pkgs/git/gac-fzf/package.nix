{ pkgs, lib }:

pkgs.stdenvNoCC.mkDerivation rec {
  pname = "gac-fzf";
  version = "unstable";

  src = pkgs.fetchurl {
    url = "https://gist.githubusercontent.com/mctrxnv/1943ce0b6752eca8ed674cf2b283fa51/raw/25004477fa4377d88f49cdf69ae9d51353857c7f/gistfile1.txt";
    sha256 = "sha256-s020FG7Nitpk//CNAL6VsXdGaFBj8BJvWwVjhlccmwI=";
  };

  nativeBuildInputs = [ pkgs.makeWrapper ];
  dontUnpack = true;

  installPhase = ''
    mkdir -p $out/bin

    install -Dm755 $src $out/bin/${pname}
    chmod +x $out/bin/${pname}

    wrapProgram $out/bin/${pname} \
      --prefix PATH ':' \
        "${
          lib.makeBinPath (
            with pkgs;
            [
              git
              fzf
            ]
          )
        }"
  '';

  meta.mainProgram = pname;
}
