{
  lib,
  ...
}:

{
  imports = lib.mkUmport ./. [
    ./default.nix
    ./programs/cli/mpd
    ./windowManagers/niri_test
    ./windowManagers/sway
  ];
}
