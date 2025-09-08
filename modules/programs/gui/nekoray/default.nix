{
  lib,
  ...
}:

with lib;

mkIf (mac "pcRyazenka" || mac "thinkpadT14") {
  persist.user.dirs = [ ".config/nekoray" ];

  programs.nekoray = {
    enable = true;
    tunMode.enable = true;
  };
}
