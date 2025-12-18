# WARN: not finished
# [X] basic config
# [X] secrets list (pizdec)
# [ ] templates (nahuya?)

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
# > sops -e -i secrets/users/myuser/github.yaml
#
# to edit encrypted file use:
# > sops secrets/<name>.env
#
# to rekey use:
# > sops updatekeys secrets/<name>.env
#
# for additional info see ../../../.sops.yaml

{
  imports = [ ./module.nix ];
  # alias config.sops.secrets.<name>.path
  # to config.sopsnix.<name>
}
// (mkIf (mac' "isoXtended") {

  packages = with pkgs; [
    sops
    age

    ssh-to-age
  ];

  sops = {
    secrets =
      mkIf (mac' "isoXtended")
        # INFO: default for every host secrets
        # for especially host create
        # > machines/machine/secerts.yaml
        (
          mkSecrets.sops [
            "password"

            "tokens/anilibme"
            "tokens/cachix"
            "tokens/discord"
            "tokens/github"
            "tokens/jerry"
            "tokens/viu"

            "services/windows"
            "services/transmission"
            "services/minecraft"
            "services/minecraft-main"
            "services/glance"

            "accounts/gmailPassword"
            "accounts/tg"
          ] "${self}/.secrets.yaml"
        );

    age = {
      # for create private key use:
      # > age-keygen -y ~/.config/sops/age/keys.txt
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
})
