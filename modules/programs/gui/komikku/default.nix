{
  pkgs,
  lib,
  ...
}:

with lib;

mkIf (itIs == "desktop") {
  persist.user.dirs = [ ".local/share/komikku" ];

  environment.systemPackages = with pkgs; [ komikku ];
}
