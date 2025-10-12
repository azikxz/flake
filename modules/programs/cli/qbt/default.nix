{
  pkgs,
  lib,
  config,
  ...
}:

with lib;
# INFO: qbittorrent cli for service
# qbt

mkIf config.services.qbittorrent.enable {
  hmPackages = [ pkgs.qbittorrent-cli ];
}
