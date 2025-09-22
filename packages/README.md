https://git.sr.ht/~neverness/nixages

hi, i re moved (not remove, i mean move) pkg from
this my repo to my flake repo, idk why lolz

```nix
{
  self,
  inputs,
  pkgs,
  lib,
}:

let
  flattenPkgs =
    separator: path: value:
    if lib.isDerivation value then
      { ${lib.concatStringsSep separator path} = value; }
    else
      lib.concatMapAttrs (name: flattenPkgs separator (path ++ [ name ])) value;

  scopeFromDirectory =
    directory:
    lib.makeScope pkgs.newScope (
      self':
      lib.filesystem.packagesFromDirectoryRecursive {
        inherit directory;
        callPackage = self'.newScope { inherit self inputs; };
      }
    );

  legacyPackages = scope.packages scope;
  scope = scopeFromDirectory ./pkgs; # select dir where located ->
  # ./pkgs/programName/package.nix
in

flattenPkgs "-" [ ] legacyPackages
```

this is previous function for generation packages

```nix
{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs =
    inputs@{
      self,
      ...
    }:
    inputs.flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = import inputs.nixpkgs {
          inherit
            system
            ;
        };

        inherit (pkgs) lib;
      in
      {
        packages = import ./packages.nix { # function above
          inherit
            self
            inputs
            pkgs
            lib
            ;
        };
      }
    );
}
```

this is previous **flake.nix**
