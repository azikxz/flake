{
  pkgs,
  lib,
  ...
}:

with lib;

mkIf (itIs == "desktop") {
  hm.home.packages = with pkgs; [
    filezilla
  ];
}
