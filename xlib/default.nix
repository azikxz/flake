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
      pkgs = import nixpkgs {
        inherit
          system
          ;
      };
    in
    {
      formatter = pkgs.nixfmt-rfc-style;
      devShells = import ./shells.nix {
        inherit
          pkgs
          ;
      };
    }
  )
// {
  inherit (nixpkgs) lib;
  nixosConfigurations =
    (import ./builder {
      inherit
        self
        inputs
        ;
    })
      (import "${self}/machines");
}
