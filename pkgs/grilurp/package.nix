{ pkgs, lib }:

pkgs.stdenvNoCC.mkDerivation {
  pname = "grilurp";
  version = "unstable";

  src = pkgs.fetchurl {
    url = "https://gist.githubusercontent.com/mctrxnv/c25fdf25c1c2cbd2268e1c9bf8207d56/raw/97852bb74bef05400138ce37dc4a43319f02e7c0/gistfile1.txt";
    sha256 = "sha256-6eHufo1S49Rbk8QhCSJQ7FRgWAF3R3t8Sr/Hclg+ksc=";
  };

  nativeBuildInputs = [ pkgs.makeWrapper ];
  dontUnpack = true;

  installPhase = ''
    mkdir -p $out/bin

    install -Dm755 $src $out/bin/grilurp
    chmod +x $out/bin/grilurp

    wrapProgram $out/bin/grilurp \
      --prefix PATH ':' \
        "${
          lib.makeBinPath (
            with pkgs;
            [
              coreutils
              grim
              jq
              libnotify
              slurp
              wl-clipboard
              hyprpicker
            ]
          )
        }"
  '';

  meta.mainProgram = "grilurp";
}
