{
  pkgs,
  lib,
  ...
}:

with lib;

mkIf (itIs == "desktop") {
  hm.home.packages = attrValues {
    inherit (pkgs)
      cachix
      hut
      nix-tree
      nurl
      ;
  };
}
