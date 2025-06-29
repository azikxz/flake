{
  pkgs,
  lib,
  ...
}:

with lib;

mkIf (machine == "pcRyazenka") {
  persist.user.dirs = [ ".local/share/komikku" ];

  environment.systemPackages = with pkgs; [ komikku ];
}
