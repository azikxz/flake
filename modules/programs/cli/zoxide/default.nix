{
  lib,
  ...
}:

with lib;

mkIf (itIs == "desktop" || itIs == "laptop") {
  persist.user.dirs = [ ".local/share/zoxide" ];

  hm.programs.zoxide = {
    enable = true;

    options = [ "--cmd cd" ];
  };
}
