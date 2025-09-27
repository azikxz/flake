{
  pkgs,
  lib,
  ...
}:

with lib;

mkIf false {
  persist.user.dirs = [ ".local/share/cartridges" ];

  environment.systemPackages = [ pkgs.cartridges ];
}
