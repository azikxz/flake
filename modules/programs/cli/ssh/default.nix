{
  lib,
  ...
}:

with lib;

mkIf (machine == "pcRyazenka" || machine == "thinkpadT14") {
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
