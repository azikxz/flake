{
  lib,
  ...
}:

# TODO: here is nothing,
# i havent idea what to do

# INFO: generates
# { specialisation.gaming = ...; };
# by sub directories

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
