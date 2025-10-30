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
# INFO:
# http://localhost:9091
# another web ui is flood

mkIf false {
  persist.dirs = [
    "/var/lib/transmission"
    savePath
  ];

  packages = [ pkgs.torque ];

  services.transmission = {
    enable = true;
    openFirewall = true;
    openPeerPorts = true;
    openRPCPort = true;

    package = pkgs.transmission_4;
    webHome = pkgs.flood-for-transmission;
    downloadDirPermissions = "775";
    performanceNetParameters = true;

    settings = {
      download-dir = savePath;
      incomplete-dir = savePath + "/temp";
      umask = "002";

      download-queue-size = 3;

      start-added-torrents = false;

      default-trackers = readFile (
        pkgs.fetchurl {
          url = "https://raw.githubusercontent.com/XIU2/TrackersListCollection/refs/heads/master/all.txt";
          sha256 = "sha256-7/zw5KFQF8HLtq8YN3D7b4zFghulo7egO3hl/7RwIbo=";
        }
      );
      # idk why

      rpc-authentication-required = false;

      rpc-host-whitelist-enabled = true;
      rpc-host-whitelist = "127.0.0.1,localhost";

      rpc-whitelist-enabled = true;
      rpc-whitelist = "127.0.0.1";

      peer-port-random-on-start = true;
      peer-limit-per-torrent = 5;
      upload-slots-per-torrent = 2;
    };

    # INFO:
    # {
    #   "rpc-username": "yourUser",
    #   "rpc-password": "password"
    # }
    credentialsFile = config.sopsnix."services/transmission";
  };

  tmp.transmission = {
    "${savePath}".d = {
      inherit (config.services.transmission)
        user
        group
        ;

      mode = "0775";
    };
  };

  networking.hosts."163.172.167.207" = [
    "bt.t-ru.org"
    "bt2.t-ru.org"
    "bt3.t-ru.org"
    "bt4.t-ru.org"
  ];
}
