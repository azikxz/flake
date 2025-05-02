{
  self,
  inputs,
  pkgs,
  lib,
  ...
}:

with lib;
with types;

rec {
  # ylib
  umport = import ./umport.nix {
    inherit
      lib
      ;
  };
  mkUmport =
    path: exclude:
    ((filter (path': baseNameOf path' == "default.nix")) (umport {
      inherit
        path
        exclude
        ;
    }));

  # enable = true; ++ enable = false;
  on.enable = true;
  off.enable = false;

  # for programs
  toGen = type: contain: generators.${toString type} { } contain;
  mkOn = list: genAttrs list (n: on);
  mkOff = list: genAttrs list (n: off);
}
// import ./nixpkgs.nix {
  inherit
    self
    inputs
    pkgs
    ;
}
