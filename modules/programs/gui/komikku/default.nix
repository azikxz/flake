{
  pkgs,
  lib,
  ...
}:

with lib;

mkIf (itIs == "desktop") {
  persist.user.dirs = [ ".local/share/komikku" ];

  hm.home.packages = with pkgs; [ filezilla ];
}
