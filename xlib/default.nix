inputs@{
  self,
  ...
}:

let
  inherit (inputs)
    nixpkgs
    flake-utils
    ;
in

flake-utils.lib.eachSystem
  [
    "x86_64-linux"
    "aarch64-linux"
  ]
  (
    system:
    let
      inherit (nixpkgs) lib;
      pkgs = import nixpkgs {
        inherit
          system
          ;
      };
    in
    {
      formatter = pkgs.nixfmt-rfc-style;
      packages = import ./packages.nix {
        inherit
          self
          inputs
          pkgs
          lib
          ;
      };
      devShells = import ./shells.nix {
        inherit
          pkgs
          ;
      };
    }
  )
// {
  nixosConfigurations =
    (import ./builder {
      inherit
        self
        inputs
        ;
    })
      (import "${self}/machines");
}
