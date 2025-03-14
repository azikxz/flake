{ pkgs, config }:

let
  css = import ./css.nix {
    inherit
      config
      ;
  };
in

pkgs.stdenv.mkDerivation {
  pname = "obsidian-stylix-theme";
  version = "0.0.1";
  src = ./.;
  installPhase = ''
    mkdir $out
    echo ${css} >> $out/theme.css
  '';
}
