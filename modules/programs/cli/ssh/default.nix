{
  lib,
  ...
}:

with lib;
# INFO: for generating ssh key use
# ssh-keygen
# then watch checl ~/.ssh/id_ed25519.pub

mkIf (mac "pcRyazenka" || mac "thinkpadT14") {
  persist.user.files = [
    ".ssh/id_ed25519"
    ".ssh/id_ed25519.pub"
    ".ssh/known_hosts"
  ];

  hm.programs.ssh = {
    enable = true;

    compression = true;

    hashKnownHosts = true;
  };
}
