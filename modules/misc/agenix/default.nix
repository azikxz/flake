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
        genSecret = path: _: {
          name = removeSuffix ".age" (baseNameOf path);
          value = {
            file = "${self}/${path}";
            mode = toString 770;
          }
          // genAttrs [
            "owner"
            # "group"
          ] (n: system.userName);
        };

        secrets' = "${self}/machines/${machine}/agenix.nix";
        machineSecrets = if (pathExists secrets') then (import secrets') else { };
        # INFO: idk how but create ./machine/machine/agenix.nix
      in
      mapAttrs' genSecret ((import "${self}/secrets.nix") // machineSecrets);

    identityPaths = [
      "/etc/ssh/ssh_host_ed25519_key"
      "${config.hm.home.homeDirectory}/.ssh/id_ed25519"
    ];
  };
})
