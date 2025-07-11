{
  pkgs,
  lib,
  ...
}:

with lib;

mkIf (mac "pcRyazenka" || mac "thinkpadT14") {
  persist.user.dirs = [ ".local/share/Trash" ];

  environment.systemPackages = [ pkgs.trash-cli ];
}
