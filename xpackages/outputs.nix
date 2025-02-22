# adapted from here
# https://github.com/drupol/pkgs-by-name-for-flake-parts

inputs:

let
  pkgs = import inputs.nix { system = "x86_64-linux"; };
  lib = inputs.nix.lib;

  flattenPkgs =
    separator: path: value:
    if lib.isDerivation value then
      { ${lib.concatStringsSep separator path} = value; }
    else
      lib.concatMapAttrs (name: flattenPkgs separator (path ++ [ name ])) value;

  scopeFromDirectory =
    directory:
    lib.makeScope pkgs.newScope (
      self:
      lib.filesystem.packagesFromDirectoryRecursive {
        inherit directory;
        callPackage = self.newScope { inherit inputs; };
      }
    );

  legacyPackages = scope.packages scope;
  scope = scopeFromDirectory ./pkgs;
in

(flattenPkgs "/" [ ] legacyPackages)
