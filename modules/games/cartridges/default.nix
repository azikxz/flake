{
  pkgs,
  lib,
  ...
}:

with lib;

mkIf (itIs == "desktop") {
  persist.user.dirs = [ ".local/share/cartridges" ];

  hm = {
    home.packages = with pkgs; [ cartridges ];
  };
}
