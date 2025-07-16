{
  pkgs,
  lib,
  config,
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

  environment.systemPackages = [ pkgs.qbittorrent-cli ];

  hm.home.file.".qbt/settings.json".text = builtins.toJSON {
    Url = "http://localhost:${toString config.services.qbittorrent.webuiPort}";
    Username = "pirate";
    Password = "passwordus";
  };

  services.qbittorrent = {
    enable = true;

    inherit savePath;
    torrentingPort = 6881;
  };

  networking.firewall = {
    allowedTCPPorts = [ 8080 ];
  };
})
