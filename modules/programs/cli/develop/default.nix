{
  pkgs,
  lib,
  ...
}:

with lib;
# INFO: use for nix develop

mkIf (mac "pcRyazenka" || mac "thinkpadT14") {
  persist.user.dirs = [ ".config/hut" ];

  hmPackages = attrValues {
    inherit (pkgs)
      cachix
      hut
      nix-init
      nix-tree
      nurl
      ;
  };
}
