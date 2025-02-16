{ pkgs }:

pkgs.stdenv.mkDerivation rec {
  pname = "canvas";
  version = "unstable-2023-08-22";

  src = pkgs.fetchFromGitHub {
    owner = "adi1090x";
    repo = pname;
    rev = "b4b1e3456d86db98052bd7735ae3c0a8799b1061";
    hash = "sha256-yyZjwU3n1UJfVQ05if3oKBNKfjURmvfHFe2zC91Zu8g=";
  };

  nativeBuildInputs = [ pkgs.makeWrapper ];
  phases = [ "installPhase" ];

  installPhase = ''
    mkdir -p $out/bin
    cp $src/canvas $out/bin
    chmod +x $out/bin/canvas
    wrapProgram $out/bin/canvas \
      --prefix PATH : ${
        with pkgs;
        lib.makeBinPath [
          imagemagick
          feh
          xcolor
          xorg.xrandr
        ]
      }
  '';
}
