{
  pkgs,
  lib,
  ...
}:

with lib;

mkIf (machine == "pcRyazenka") {
  persist.user.dirs = [
    ".config/Mumble"
    ".local/share/Mumble"
  ];

  environment.systemPackages = with pkgs; [ mumble ];
}
