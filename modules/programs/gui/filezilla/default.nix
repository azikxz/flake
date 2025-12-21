{
  pkgs,
  lib,
  ...
}:

with lib;
# INFO:
# ftp client

mkIf (mac "pcRyazenka" || mac "thinkpadT14") {
  hmPackages = [ pkgs.filezilla ];
}
