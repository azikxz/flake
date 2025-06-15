{
  pkgs,
  lib,
  ...
}:

with lib;

mkIf (itIs == "laptop") {
  persist.user.dirs = [ ".srb2" ];

  environment.systemPackages = with pkgs; [ srb2 ];
}
