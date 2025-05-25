{
  lib,
  ...
}:

with lib;

mkIf (itIs == "desktop" || itIs == "laptop") {
  persist.user.dirs = [
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
