{
  lib,
  ...
}:

with lib;

mkIf (machine == "pcRyazenka" || machine == "thinkpadT14") {
  persist.user.dirs = [ ".local/share/zoxide" ];

  hm.programs.zoxide = {
    enable = true;

    options = [ "--cmd cd" ];
  };
}
