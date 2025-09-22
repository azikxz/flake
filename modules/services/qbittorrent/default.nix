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
# http://localhost:8080
# or if u want use flood, enable service

(mkIf (mac "pcRyazenka" || mac "thinkpadT14") {
  persist.dirs = [
    "/var/lib/qBittorrent"
    savePath
  ];

  environment.systemPackages = [ pkgs.self'.qb-hash ];

  services.qbittorrent = {
    enable = true;

    openFirewall = true;
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
        UseUPnP = false;
        Username = "pirate";
        Password_PBKDF2 = "@ByteArray(HsNaxVT2CfZtscvsC7dTtA==:+vOvJK4/ZWgvtSuNwFPXsro2CzGwa2uuDq5lW8faKBNxV4UqkHhTeiC9kANmeYevRg0xtJmhumedqGgCEttQLw==)"; # gen with qbithash
      };

      RSS.Session = {
        EnableProcessing = true;
        MaxArticlesPerFeed = 2000;
        RefreshInterval = 10;
      };
    };
  };

  tmp.qbittorrent = {
    "${savePath}/"."d" = {
      inherit (config.services.qbittorrent)
        user
        group
        ;

      mode = "0775";
    };
  };
})
