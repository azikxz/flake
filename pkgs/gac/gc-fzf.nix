{ pkgs, lib }:

pkgs.stdenvNoCC.mkDerivation rec {
  pname = "gc-fzf";
  version = "unstable";

  src = pkgs.fetchurl {
    url = "https://gist.githubusercontent.com/mctrxnv/1943ce0b6752eca8ed674cf2b283fa51/raw/8da8ca0421bc0c8639c602f1293ee18ba2a0ed33/gistfile1.txt";
    sha256 = "sha256-Rn84IiR4nRqCFcCCSF3bHQiBkjtEsL1dRBlkk4Ne0RI=";
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
