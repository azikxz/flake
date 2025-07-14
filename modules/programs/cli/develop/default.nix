{
  pkgs,
  lib,
  ...
}:

with lib;

mkIf (mac "pcRyazenka") {
  persist.user.dirs = [ ".config/hut" ];

  environment.systemPackages = attrValues {
    inherit (pkgs)
      cachix
      hut
      nix-init
      nix-tree
      nurl
      ;
  };
}
