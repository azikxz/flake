inputs@{
  self,
  ...
}:

let
  inherit (inputs) nixpkgs;
  system = "x86_64-linux";
  pkgs = import nixpkgs { inherit system; };
  lib = nixpkgs.lib;

  build = import ./builder { inherit self inputs; };
  machines = (import "${self}/machines");
in

{
  nixosConfigurations = build machines;
  formatter.${system} = pkgs.nixfmt-rfc-style;
  packages.${system} = import ./packages.nix {
    inherit
      inputs
      pkgs
      lib
      ;
  };
  devShells.${system} =
    with pkgs;
    let
      mk =
        p:
        mkShell {
          shellHook = ''exec fish'';
          packages = p;
        };
    in
    {
      nixDev = mk [
        nixfmt-rfc-style
        nix-init
        cachix
      ];
      rust = mk [
        rustfmt
        rustc
        cargo
      ];
      python = mk [
        python3
        pipx
      ];
    };
}
