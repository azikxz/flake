{
  pkgs,
  lib,
  ...
}:

with lib;

mkIf (itIs == "desktop") {
  persist.user.dirs = [
    ".config/Mumble"
    ".local/share/Mumble"
  ];

  hm.home.packages = with pkgs; [ mumble ];
}
