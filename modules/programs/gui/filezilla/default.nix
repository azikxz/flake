{
  pkgs,
  lib,
  ...
}:

with lib;
# INFO:
# ftp client

mkIf (mac "pcRyazenka") {
  hmPackages = [ pkgs.filezilla ];
}
