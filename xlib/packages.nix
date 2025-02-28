{
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
      self:
      lib.filesystem.packagesFromDirectoryRecursive {
        inherit directory;
        callPackage = self.newScope { inherit inputs; };
      }
    );

  legacyPackages = scope.packages scope;
  scope = scopeFromDirectory ../pkgs;
in

flattenPkgs "/" [ ] legacyPackages
