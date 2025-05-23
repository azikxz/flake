{
  lib,
  ...
}:

with lib;

mkIf (itIs == "desktop" || itIs == "laptop") {
  persist.user.dirs = [
    ".local/share/syncthing"
    ".local/state/syncthing"
  ];

  hm.services.syncthing.enable = true;
}
