{
  pkgs,
  lib,
  ...
}:

with lib;

mkIf false {
  persist.user.dirs = [ ".local/share/komikku" ];

  environment.systemPackages = with pkgs; [ komikku ];
}
