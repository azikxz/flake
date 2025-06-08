{
  pkgs,
  lib,
  ...
}:

with lib;

mkIf (itIs == "desktop") {
  persist.user.dirs = [ ".config/hut" ];

  hm.home.packages = attrValues {
    inherit (pkgs)
      cachix
      hut
      nix-tree
      nurl
      ;
  };
}
