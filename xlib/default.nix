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

  build = import ./builder {
    inherit
      self
      inputs
      pkgs
      ;
  };
  machines = (import "${self}/machines");
  mk = import ./other {
    inherit
      forAllSystems
      inputs
      pkgs
      lib
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
}

// (lib.genAttrs [
  "formatter"
  "packages"
  "devShells"
] (n: mk.${n}))
