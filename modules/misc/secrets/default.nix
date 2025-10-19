{
  self,
  lib,
  config,
  ...
}:

with lib;

{
  imports = [ ./module.nix ];
  # alias config.age.secrets.<name>.path
  # to config.secrets.<name>

  age = {
    secrets =
      let
        secretsDir = "${self}/secrets";
        listFiles = builtins.readDir secretsDir;

        ageFiles = filterAttrs (name: type: type == "regular" && hasSuffix ".age" name) listFiles;

        genSecret = name: _: {
          name = removeSuffix ".age" name;
          value = {
            file = concatStringsSep "/" [
              secretsDir
              name
            ];

            mode = toString 770;
          }
          // genAttrs [
            "owner"
            "group"
          ] (n: system.userName);
        };
      in
      mapAttrs' genSecret ageFiles;

    identityPaths = [
      "/etc/ssh/ssh_host_ed25519_key"
      "${config.hm.home.homeDirectory}/.ssh/id_ed25519"
    ];
  };
}
