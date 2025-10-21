# WARN: not finished
# [X] basic config
# [ ] secrets list
# [ ] templates

{
  self,
  pkgs,
  lib,
  config,
  ...
}:

with lib;
# INFO:
# for encrypt existed file use:
#   sops -e -i secrets/users/myuser/github.yaml
#
# to edit encrypted file use:
#   sops secrets/some.env

{
  imports = [ ./module.nix ];
  # alias config.age.secrets.<name>.path
  # to config.agenix.<name>

  packages = with pkgs; [
    sops
    age

    ssh-to-age
  ];

  sops = {
    defaultSopsKey = "${self}/.secrets.yaml";
    defaultSopsFormat = "yaml";

    age = {
      keyFile =
        let
          keysText = "${config.hm.xdg.configHome}/sops/age/keys.txt";
        in
        if (config.environment.persistence != { }) then
          (concatStringsSep "/" [
            paths.persist
            keysText
          ])
        else
          keysText;

      sshKeyPaths = [
        "/etc/ssh/ssh_host_ed25519_key"
        "${config.hm.home.homeDirectory}/.ssh/id_ed25519"
      ];
    };
  };
}
