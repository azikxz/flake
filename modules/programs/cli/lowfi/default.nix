{
  pkgs,
  lib,
  ...
}:

with lib;

mkIf (itIs == "desktop") {
  hm.home.packages = [ pkgs.lowfi ];
}
