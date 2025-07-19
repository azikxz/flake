{
  lib,
  ...
}:

# TODO: here is nothing,
# i havent idea what to do

# INFO: generates
# { specialisation.gaming = ...; };
# by sub directories
#
#  .
# ├─  default.nix (current file)
# │
# ├─  gaming
# │  └─  default.nix
# │
# └─  steamDeck
#    └─  default.nix

with lib;

{
  specialisation = listToAttrs (
    map (name: {
      inherit name;
      value =
        (name: {
          inheritParentConfig = true;
          configuration = {
            system.nixos.tags = [ name ];
            imports = [ ./${name}/default.nix ];
          };
        })
          name;
    }) (attrNames (filterAttrs (path: type: type == "directory") (builtins.readDir ./.)))
  );
}
