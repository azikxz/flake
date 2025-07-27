{
  pkgs,
  lib,
  ...
}:

with lib;
# INFO: use for nix develop

mkIf (mac "pcRyazenka" || mac "thinkpadT14") {
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
