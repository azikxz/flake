{
  pkgs,
  lib,
  ...
}:

with lib;

mkIf (itIs == "desktop" || itIs == "laptop") {
  persist.user.dirs = [ ".local/share/Trash" ];

  environment.systemPackages = [ pkgs.trash-cli ];
}
