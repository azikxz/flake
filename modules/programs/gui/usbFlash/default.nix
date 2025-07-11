{
  pkgs,
  lib,
  ...
}:

with lib;

mkIf (mac "pcRyazenka") {
  environment.systemPackages = with pkgs; [ popsicle ];
}
