{
  pkgs,
  lib,
  ...
}:

with lib;

mkIf (itIs == "desktop") {
  persist.user.dirs = [ ".srb2" ];

  environment.systemPackages = with pkgs; [ srb2 ];
}
