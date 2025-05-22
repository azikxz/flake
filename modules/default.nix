{
  lib,
  ...
}:

{
  imports = lib.mkUmport ./. [
    ./default.nix
    ./windowManagers/niri_test
    ./windowManagers/sway
  ];
}
