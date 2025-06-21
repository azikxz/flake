{
  lib,
  ...
}:

{
  imports = lib.mkUmport ./. [
    ./default.nix
    # ./programs/gui/obsidian
    ./windowManagers/niri_test
    ./windowManagers/sway
  ];
}
