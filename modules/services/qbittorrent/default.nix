{
  lib,
  ...
}:

with lib;

{
  imports = [ ./module.nix ];
}
// (mkIf (itIs == "desktop" || itIs == "laptop") {
  persist.dirs = [ "/var/lib/qBittorrent" ];

  services.qbittorrent = {
    enable = true;

    torrentingPort = 6881;

    serverConfig = {
      LegalNotice.Accepted = true;

      BitTorrent.Session = {
        TempPathEnabled = true;
        DefaultSavePath = "/media/torrents";
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
        Password_PBKDF2 = "@ByteArray(cHoEZXCQHgzrYc5AL5txtA==:gCU9lPygf4VOGPPqeU1KJvabHVcpwgWVLr4tu3RF8lc2Pemn4IOHLxzShpednT8LsYG7HWdl1OS7ey97CXf2DA==)"; # gen with qbithash
      };

      RSS.Session = {
        EnableProcessing = true;
        MaxArticlesPerFeed = 2000;
        RefreshInterval = 10;
      };
    };
  };
})
