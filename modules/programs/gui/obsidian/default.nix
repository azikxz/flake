{
  pkgs,
  lib,
  config,
  ...
}:

with lib;
# INFO:
# best notes database
#
# WARN:
# press enable plugins at start

(mkIf (mac "pcRyazenka" || mac "thinkpadT14") {
  persist.user.dirs = [ ".config/obsidian" ];

  hm = {
    imports = [ ./patch.nix ];

    programs.obsidian = {
      enable = true;

      extraSettings.frame = "native";

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
  };
})
