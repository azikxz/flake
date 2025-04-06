{
  pkgs,
  lib,
  config,
  ...
}:

with lib;
with x;
let
  cfg = config.module.services.qbittorrent;
in

{
  options = {
    module.services.qbittorrent = {
      enable = mkBool false;
    };
  };

  imports = [ ./module.nix ];
  config = mkIf cfg.enable {
    services.qbittorrent = on // {
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
          AlternativeUIEnabled = true;
          RootFolder = getExe' pkgs.vuetorrent "vuetorrent";
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
  };
}
