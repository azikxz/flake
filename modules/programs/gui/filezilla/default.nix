{
  pkgs,
  lib,
  ...
}:

with lib;

mkIf (itIs == "desktop") {
  environment.systemPackages = with pkgs; [ filezilla ];
}
