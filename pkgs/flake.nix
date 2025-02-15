{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    parts.url = "github:hercules-ci/flake-parts";
  };

  outputs =
    inputs:
    inputs.parts.lib.mkFlake { inherit inputs; } {
      systems = [
        "x86_64-linux"
        "aarch64-linux"
        "x86_64-darwin"
        "aarch64-darwin"
      ];
      perSystem =
        { pkgs, ... }:
        let
          mk = dir: pkgs.callPackage dir { };
        in
        {
          packages = {
            anicli-ru = mk ./anicli;
            lowfi = mk ./lowfi;
          };
        };
    };
}
