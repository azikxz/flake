{
  pkgs,
  lib,
  ...
}:

with lib;

mkIf (itIs == "desktop") {
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
