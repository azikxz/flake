{
  lib,
  ...
}:

with lib;
let
  savePath = "/media/torrents";
in

{
  imports = [ ./module.nix ];
}
// (mkIf (mac "pcRyazenka" || mac "thinkpadT14") {
  persist.dirs = [
    "/var/lib/qBittorrent"
    savePath
  ];

  services.qbittorrent = {
    enable = true;

    inherit savePath;
    torrentingPort = 6881;
  };
})
