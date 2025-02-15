{
  lib,
  config,
  ...
}:

with lib;
with x;
let
  cfg = config.module.programs.gui.qbittorrent;
in

{
  options = {
    module.programs.gui.qbittorrent = {
      enable = mkBool false;
    };
  };

  config = mkIf cfg.enable {
    xdg.configFile = {
      "qBittorrent/themes/default/config.json".text = x.gen "toJSON" {
        "version" = 2;
        "colors.dark" = {
          "Log.BannedPeer" = "#b66467";
          "Log.Critical" = "#b66467";
          "Log.Info" = "#8da3b9";
          "Log.TimeStamp" = "#bbb6b6";
          "Log.Warning" = "#d9bc8c";
          "TransferList.CheckingDownloading" = "#8c977d";
          "TransferList.CheckingResumeData" = "#8c977d";
          "TransferList.CheckingUploading" = "#8c977d";
          "TransferList.Downloading" = "#d9bc8c";
          "TransferList.DownloadingMetadata" = "#d9bc8c";
          "TransferList.Error" = "#b66467";
          "TransferList.ForcedDownloading" = "#d9bc8c";
          "TransferList.ForcedDownloadingMetadata" = "#d9bc8c";
          "TransferList.ForcedUploading" = "#d9bc8c";
          "TransferList.MissingFiles" = "#b66467";
          "TransferList.Moving" = "#8aa6a2";
          "TransferList.PausedDownloading" = "#a988b0";
          "TransferList.PausedUploading" = "#a988b0";
          "TransferList.QueuedDownloading" = "#d9bc8c";
          "TransferList.QueuedUploading" = "#d9bc8c";
          "TransferList.StalledDownloading" = "#8c977d";
          "TransferList.StalledUploading" = "#bbb6b6";
          "TransferList.Uploading" = "#bbb6b6";
        };
      };
    };
  };
}
