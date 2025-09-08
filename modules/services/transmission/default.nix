{
  pkgs,
  lib,
  config,
  ...
}:

with lib;
let
  savePath = "/media/torrents-other";
in

mkIf false {
  persist.dirs = [
    "/var/lib/transmission"
    savePath
  ];

  services.transmission = {
    enable = true;

    package = pkgs.transmission_4;
    webHome = pkgs.flood-for-transmission;
    downloadDirPermissions = "775";

    performanceNetParameters = true;
    openFirewall = true;
    openPeerPorts = true;
    openRPCPort = true;

    settings = {
      download-dir = savePath;
      incomplete-dir = savePath + "/temp";

      download-queue-size = 3;

      start-added-torrents = false;

      rpc-authentication-required = true;
      rpc-host-whitelist-enabled = true;
      rpc-username = "root";

      peer-port-random-on-start = true;
      peer-limit-per-torrent = 5;
      upload-slots-per-torrent = 2;
    };
  };

  tmp.transmission = {
    "${savePath}".d = {
      inherit (config.services.transmission)
        user
        group
        downloadDirPermissions
        ;
    };
  };

  networking.hosts."163.172.167.207" = [
    "bt.t-ru.org"
    "bt2.t-ru.org"
    "bt3.t-ru.org"
    "bt4.t-ru.org"
  ];
}
