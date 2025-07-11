{
  pkgs,
  lib,
  ...
}:

with lib;

mkIf (mac "pcRyazenka") {
  persist.user.dirs = [ ".local/share/komikku" ];

  environment.systemPackages = with pkgs; [ komikku ];
}
