{
  pkgs,
  lib,
}:

lib.genAttrs [
  "mkNpm"
  "mkTheme"
  "mkYarn"
] (n: pkgs.callPackage ./${n}.nix { })
