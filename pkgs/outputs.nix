{ inputs, list, ... }:
let
  pkgs = inputs.nixpkgs.legacyPackages."x86_64-linux";
  lib = inputs.nixpkgs.lib;
  mk = n: lib.genAttrs n (p: pkgs.callPackage ./${p} { });
in
mk list
