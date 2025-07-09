{
  lib,
  ...
}:

{
  imports = lib.mkUmport ./. [
    ./default.nix
    ./programs/cli/mpd
    ./programs/windowManagers/niri_test
    ./programs/windowManagers/sway
  ];
}
