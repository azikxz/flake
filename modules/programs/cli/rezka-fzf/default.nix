{
  pkgs,
  lib,
  ...
}:

with lib;
# INFO:
# watch movie/series/anime from hdrezka
# in terminal via fzf and mpv
#
# WARN:
# set url in ~/.config/hdrezka-tui/config.json

mkIf (mac "pcRyazenka" || mac "thinkpadT14") {
  hmPackages = [ pkgs.rezka-fzf ];
}
