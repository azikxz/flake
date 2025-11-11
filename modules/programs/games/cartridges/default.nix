{
  pkgs,
  lib,
  ...
}:

with lib;
# INFO:
# bullshit
# but beauty

mkIf false {
  persist.user.dirs = [ ".local/share/cartridges" ];

  hmPackages = [ pkgs.cartridges ];
}
