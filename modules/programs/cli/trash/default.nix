{
  pkgs,
  lib,
  ...
}:

with lib;
# INFO:
# for clear trash use
# > trash-empty

mkIf (mac "pcRyazenka" || mac "thinkpadT14") {
  persist.user.dirs = [ ".local/share/Trash" ];

  hmPackages = [ pkgs.trash-cli ];

  hm.home.shellAliases = {
    rm = getExe' pkgs.trash-cli "trash-put";
  };
}
