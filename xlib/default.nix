inputs@{
  self,
  ...
}:

let
  inherit (inputs) nixpkgs;
  pkgs = import inputs.nixpkgs { system = "x86_64-linux"; };
  lib = inputs.nixpkgs.lib;

  build = import ./builder { inherit self inputs; };
  machines = (import "${self}/machines");

  forAllSystems = i: nixpkgs.lib.genAttrs sys i;
  sys = [
    "x86_64-linux"
    "aarch64-linux"
    "x86_64-darwin"
    "aarch64-darwin"
  ];
in

{
  nixosConfigurations = build machines;

  packages = import ./packages.nix { inherit inputs pkgs lib; };
  devShells = import ./devShells.nix { inherit forAllSystems pkgs; };
  formatter = import ./formatter.nix { inherit forAllSystems pkgs; };
}
