# WARN:
# [X] basic config
# [X] finished? yes it works

{
  self,
  pkgs,
  lib,
  config,
  ...
}:

with lib;
# INFO:
# for create encrypted file use:
# > cd secrets
# > agenix -e <name>.age
#
# to view whay in encrypted file use:
# > agenix -d <name>.age
#
# to rekey use:
# > agenix -r
#
# for additional info see ../../../secrets/secrets.nix

{
  imports = [ ./module.nix ];
  # alias config.age.secrets.<name>.path
  # to config.agenix.<name>
}
// (mkIf (mac' "isoXtended") {

  packages = with pkgs; [
    agenix
  ];

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
            # "group"
          ] (n: system.userName);
        };
      in
      mapAttrs' genSecret ageFiles;

    identityPaths = [
      "/etc/ssh/ssh_host_ed25519_key"
      "${config.hm.home.homeDirectory}/.ssh/id_ed25519"
    ];
  };
})
