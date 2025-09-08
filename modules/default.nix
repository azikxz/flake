{
  lib,
  ...
}:

{
  imports = lib.mkUmport ./. [
    ./default.nix
    ./programs/cli/mpd
    ./programs/windowManagers/sway
  ];
}
