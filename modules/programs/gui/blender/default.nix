{
  pkgs,
  lib,
  ...
}:

with lib;

mkIf (machine == "pcRyazenka") {
  environment.systemPackages = with pkgs; [ blender ];
}
