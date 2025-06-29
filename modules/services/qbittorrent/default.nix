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
// (mkIf (machine == "pcRyazenka" || machine == "thinkpadT14") {
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
