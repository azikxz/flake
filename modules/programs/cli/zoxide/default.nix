{
  lib,
  ...
}:

with lib;
# INFO: i replaced z for cd

mkIf (mac "pcRyazenka" || mac "thinkpadT14") {
  persist.user.dirs = [ ".local/share/zoxide" ];

  hm.programs.zoxide = {
    enable = true;

    options = [ "--cmd cd" ];
  };
}
