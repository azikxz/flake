{
  pkgs,
  lib,
  config,
  ...
}:

with lib;

mkIf (mac "pcRyazenka") {
  persist.user.dirs = [ ".config/obsidian" ];

  hm.programs.obsidian = {
    enable = true;

    vaults = mapAttrs (
      name: _:
      import (./vaults + "/${name}/main.nix") {
        inherit
          pkgs
          lib
          config
          ;
      }
    ) (filterAttrs (name: type: type == "directory") (builtins.readDir ./vaults));
  };
}
