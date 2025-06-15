{
  pkgs,
  lib,
  ...
}:

with lib;

mkIf (itIs == "desktop") {
  environment.systemPackages = [ pkgs.lowfi ];
}
