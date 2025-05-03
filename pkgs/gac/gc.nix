{ pkgs, lib }:

pkgs.stdenvNoCC.mkDerivation rec {
  pname = "gc";
  version = "unstable";

  src = pkgs.fetchurl {
    url = "https://gist.githubusercontent.com/mctrxnv/7ddc30a64bf4ed481efda56e90065d08/raw/46ffb6cbf069f0000a0c8ff77376e9fa09c5cebf/gistfile1.txt";
    sha256 = "sha256-l/HWelNMb0I0Ys6Py4yzZNPLlIMnlw4akVzFkpdh2Ew=";
  };

  nativeBuildInputs = [ pkgs.makeWrapper ];
  dontUnpack = true;

  installPhase = ''
    mkdir -p $out/bin

    install -Dm755 $src $out/bin/${pname}
    chmod +x $out/bin/${pname}

    wrapProgram $out/bin/${pname} \
      --prefix PATH ':' \
        "${lib.makeBinPath (with pkgs; [ git ])}"
  '';

  meta.mainProgram = pname;
}
