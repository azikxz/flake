{
  pkgs,
  lib,
  ...
}:

with lib;

mkIf (machine == "pcRyazenka" || machine == "thinkpadT14") {
  persist.user.dirs = [ ".local/share/Trash" ];

  environment.systemPackages = [ pkgs.trash-cli ];
}
