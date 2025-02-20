inputs@{
  self,
  ...
}:

let
  inherit (inputs) nixpkgs;
  pkgs = import inputs.nix { system = "x86_64-linux"; };
  build = import ./builder { inherit self inputs; };
  devShells = import ./devShells.nix { inherit pkgs; };

  forAllSystems = i: nixpkgs.lib.genAttrs sys i;
  sys = [
    "x86_64-linux"
    "aarch64-linux"
    "x86_64-darwin"
    "aarch64-darwin"
  ];
in

{
  nixosConfigurations = build (import "${self}/machines").nixos;

  devShells = forAllSystems (system: devShells);

  formatter = forAllSystems (system: {
    ${system} = pkgs.nixfmt-rfc-style;
  });
}
