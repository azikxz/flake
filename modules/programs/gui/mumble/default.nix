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

  environment.systemPackages = with pkgs; [ mumble ];
}
