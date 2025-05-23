{
  pkgs,
  lib,
  ...
}:

with lib;

mkIf false {
  systemd.services.transmission.serviceConfig.UMask = mkForce "0037";

  services.transmission = rec {
    enable = true;

    package = pkgs.transmission_4;

    home = "/media/torrents";
    webHome = pkgs.flood-for-transmission;
    downloadDirPermissions = "775";

    performanceNetParameters = true;
    openRPCPort = true;
    openPeerPorts = true;

    settings = {
      peer-limit-per-torrent = 5;
      upload-slots-per-torrent = 2;
      incomplete-dir-enabled = false;
      download-dir = home;
    };
  };

  networking.hosts."163.172.167.207" = [
    "bt.t-ru.org"
    "bt2.t-ru.org"
    "bt3.t-ru.org"
    "bt4.t-ru.org"
  ];
}
