{
  pkgs,
  lib,
  config,
  ...
}:

with lib;
let
  cfg = config.services.qbittorrent;
  savePath = "/media/torrents";
  ssl = false;
in
# INFO:
# or if u want use flood, enable service
#
# http://localhost:8080

mkIf (mac "pcRyazenka" || mac "thinkpadT14") {
  persist.dirs = [
    "/var/lib/qBittorrent"
    savePath
  ];

  sops.secrets =
    genAttrs
      [
        "ssl/qbittorrent/cert"
        "ssl/qbittorrent/key"
      ]
      (n: {
        owner = mkForce cfg.user;
        restartUnits = [ "qbittorrent.service" ];
      });

  environment.systemPackages = [ pkgs.qbt-tui ];

  services.qbittorrent = {
    enable = true;
    openFirewall = true;

    webuiPort = 8112;
    torrentingPort = 6881;

    serverConfig = {
      LegalNotice.Accepted = true;

      BitTorrent.Session = {
        TempPathEnabled = true;
        DefaultSavePath = savePath;
        QueueingSystemEnabled = true;
        IgnoreSlowTorrentsForQueueing = true;
        SlowTorrentsDownloadRate = 40; # kbps
        SlowTorrentsUploadRate = 40; # kbps
        GlobalMaxInactiveSeedingMinutes = 43800;
        GlobalMaxSeedingMinutes = 10080;
        GlobalMaxRatio = 2;
        MaxActiveCheckingTorrents = 2;
        MaxActiveDownloads = 5;
        MaxActiveUploads = 15;
        MaxActiveTorrents = 20;
        MaxConnections = 600;
        MaxUploads = 200;
      };

      Preferences.WebUI = {
        Enabled = true;
        AuthSubnetWhitelistEnabled = true;
        LocalHostAuth = false;
        UseUPnP = true;
        Username = system.userName;
        Password_PBKDF2 = readFile pkgs.qb-hash-gen;
        Address = "0.0.0.0";
      }
      // (optionalAttrs ssl {
        HTTPS = {
          Enabled = true;
          CertificatePath = config.sopsnix."ssl/qbittorrent/cert";
          KeyPath = config.sopsnix."ssl/qbittorrent/key";
        };
      });

      RSS.Session = {
        EnableProcessing = true;
        MaxArticlesPerFeed = 2000;
        RefreshInterval = 10;
      };
    };
  };

  systemd.services.qbittorrent = {
    serviceConfig = {
      UMask = "0002"; # 775
    };
  };

  tmp.qbittorrent = {
    "${savePath}".d = {
      inherit (config.services.qbittorrent)
        user
        group
        ;

      mode = "0775";
    };
  };
}
