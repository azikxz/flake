{ pkgs, lib }:

pkgs.stdenvNoCC.mkDerivation {
  pname = "grilurp";
  version = "0.1";

  src = ./.;

  nativeBuildInputs = [ pkgs.makeWrapper ];

  installPhase = ''
    mkdir -p $out/bin

    install -Dm755 grilurp $out/bin/grilurp
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
