inputs@{
  self,
  ...
}:

let
  inherit (inputs) nixpkgs;
  system = "x86_64-linux";
  lib = nixpkgs.lib;
  pkgs = import nixpkgs {
    inherit
      system
      ;
  };

  machines = import (self + "/machines");
  build = import ./builder {
    inherit
      self
      inputs
      pkgs
      ;
  };

  forAllSystems = i: lib.genAttrs sys i;
  sys = [
    "x86_64-linux"
    "aarch64-linux"
    "x86_64-darwin"
    "aarch64-darwin"
  ];
in

{
  nixosConfigurations = build machines;
  formatter = forAllSystems (system: pkgs.nixfmt-rfc-style);
  devShells = forAllSystems (
    system:
    (import ./shells.nix {
      inherit
        pkgs
        ;
    })
  );
}
