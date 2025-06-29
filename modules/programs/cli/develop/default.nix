{
  pkgs,
  lib,
  ...
}:

with lib;

mkIf (machine == "pcRyazenka") {
  persist.user.dirs = [ ".config/hut" ];

  environment.systemPackages = attrValues {
    inherit (pkgs)
      cachix
      hut
      nix-tree
      nurl
      ;
  };
}
