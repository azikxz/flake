{
  pkgs,
  lib,
  ...
}:

with lib;

mkIf (mac "pcRyazenka") {
  persist.user.dirs = [
    ".config/Mumble"
    ".local/share/Mumble"
  ];

  environment.systemPackages = with pkgs; [ mumble ];
}
