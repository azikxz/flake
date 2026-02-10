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
# or if u want use flood, enable service
#
# http://localhost:8080

mkIf (mac "pcRyazenka" || mac "thinkpadT14") {
  persist.dirs = [
    "/var/lib/qBittorrent"
    savePath
  ];

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
        Password_PBKDF2 = "@ByteArray(IoH2ujUzBVy3G7m2I3GoVw==:wnPcHXPppcu+hGgC3m4yPG0cgRRMmcmboTJWzw0KL5FNZ9IhxNVHzZd1Z7t+bndBCkvxi3lXIR8kdMK6C1fRaQ==)";
        Address = "0.0.0.0";
      };

      RSS.Session = {
        EnableProcessing = true;
        MaxArticlesPerFeed = 2000;
        RefreshInterval = 10;
      };

      Network.Proxy = {
        # INFO:
        #
        # px1.blockme.site:3128
        # px2.blockme.site:3128
        #
        # https://rutracker.org/forum/viewtopic.php?t=5134313
        HostnameLookupEnabled = true;
        IP = "px1.blockme.site";
        Port = 3128;
        Type = "HTTP";
      };

      AutoRun = {
        enabled = true;
        program = "Finished %N in %D";
        /*
          %N: Torrent name
          %L: Category
          %G: Tags (separated by comma)
          %F: Content path (same as root path for multifile torrent)
          %R: Root path (first torrent subdirectory path)
          %D: Save path
          %C: Number of files
          %Z: Torrent size (bytes)
          %T: Current tracker
          %I: Info hash v1
          %J: Info hash v2
          %K: Torrent ID
        */
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
