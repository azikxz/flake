{
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
}
// {
  # for programs
  toGen = type: contain: generators.${toString type} { } contain;
  recMerge = lib.foldl' lib.attrsets.recursiveUpdate { };
}
// import ./mkBoolAttrs.nix {
  inherit
    lib
    ;
}
// import ./nixpkgs.nix {
  inherit
    inputs
    pkgs
    ;
}
