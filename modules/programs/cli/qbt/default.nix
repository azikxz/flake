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
  persist.user.dirs = [ ".qbt" ];

  hmPackages = [ pkgs.qbittorrent-cli ];
}
