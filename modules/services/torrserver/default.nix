{
  pkgs,
  lib,
  ...
}:

with lib;
let
  dir = "/var/lib/torrserver";
in
# INFO:
# watch torrents when it downloads
#
# http://localhost:8090

mkIf (mac "pcRyazenka" || mac "thinkpadT14") {
  persist.dirs = [ dir ];

  systemd.services = {
    torrserver = {
      after = [ "network.target" ];

      wantedBy = [ "multi-user.target" ];

      serviceConfig = {
        Restart = "on-failure";
        Type = "simple";
        TimeoutSec = 30;

        User = "media";
        Group = "media";

        StateDirectory = [ "torrserver" ];
        StateDirectoryMode = mkDefault 775;

        ExecStart = ''
          ${getExe pkgs.torrserver} \
          -d /var/lib/torrserver \
          -p 8223
        '';
      };
    };
  };

  tmp.qbittorrent = {
    "${dir}/temp".d = {
      user = "media";
      group = "media";
      mode = "0775";
    };

    "${dir}/settings.json"."L+" = {
      user = "media";
      group = "media";
      mode = "1400";
      argument = toString (
        (pkgs.formats.json { }).generate "settings.json" {
          BitTorr = {
            CacheSize = 67108864;
            ConnectionsLimit = 25;
            DisableDHT = false;
            DisablePEX = false;
            DisableTCP = false;
            DisableUPNP = false;
            DisableUTP = false;
            DisableUpload = false;
            DownloadRateLimit = 0;
            EnableDLNA = false;
            EnableDebug = false;
            EnableIPv6 = false;
            EnableRutorSearch = false;
            ForceEncrypt = false;
            FriendlyName = "";
            PeersListenPort = 0;
            PreloadCache = 50;
            ReaderReadAHead = 95;
            ResponsiveMode = false;
            RetrackersMode = 1;
            TorrentDisconnectTimeout = 30;
            TorrentsSavePath = "${dir}/temp";
            UploadRateLimit = 0;
          }
          // (
            let
              mk =
                bool:
                (genAttrs [
                  "UseDisk"
                  "RemoveCacheOnDrop"
                ] (n: true));
            in
            if (mac "pcRyazenka") then (mk true) else (mk false)
          );
        }
      );
    };
  };

  networking.firewall = mkIf false {
    allowedTCPPorts = [ 8223 ];
  };
}
