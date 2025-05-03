{ pkgs, lib }:

let
  gc = lib.getExe (pkgs.callPackage ./gc.nix { });
  gc-fzf = lib.getExe (pkgs.callPackage ./gc-fzf.nix { });
in

pkgs.stdenvNoCC.mkDerivation rec {
  pname = "gc-helix";
  version = "unstable";

  src = ./.;

  installPhase = ''
    mkdir -p $out/bin

    install -Dm755 ${gc}     $out/bin/
    install -Dm755 ${gc-fzf} $out/bin/
  '';

  meta.mainProgram = pname;
}
