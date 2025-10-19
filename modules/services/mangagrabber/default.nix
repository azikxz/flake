{
  pkgs,
  lib,
  ...
}:

with lib;
# WARN: im too lazy to finish it
# http://localhost:8888

mkIf false {
  persist.dirs = [ "/var/lib/readmanga-grabber" ];

  systemd.services = {
    readmanga-grabber = {
      after = [ "network.target" ];

      wantedBy = [ "multi-user.target" ];

      serviceConfig = {
        Restart = "on-failure";
        Type = "simple";
        TimeoutSec = 30;

        User = "media";
        Group = "media";

        StateDirectory = [ "readmanga-grabber" ];
        StateDirectoryMode = mkDefault 775;

        ExecStart = getExe pkgs.self'.manga-grabber;
      };
    };
  };

  tmp.readmanga-grabber = {
    "/var/lib/readmanga-grabber".d = {
      user = "media";
      group = "media";
      mode = "0775";
    };

    "/var/lib/readmanga-grabber/grabber_config.json"."L+" = {
      user = "media";
      group = "media";
      mode = "1400";

      argument = toString (
        pkgs.writeText "qBittorrent.conf" (
          builtins.toJSON {
            "savepath" = "Manga/";
            "fav_title" = "ru";
            "show_gui" = true;
            "UserAgent" = "";

            "server" = {
              "addr" = "127.0.0.1";
              "port" = "8888";
            };

            "readmanga" = {
              "timeout_image" = 500;
              "timeout_chapter" = 1000;
            };

            "mangalib" = {
              "timeout_image" = 500;
              "timeout_chapter" = 1000;
            };

            "proxy" = {
              "type" = "";
              "addr" = "";
              "port" = "";

              "use" = {
                "mangalib" = false;
                "readmanga" = false;
              };
            };

            "CurrentURLs" = {
              "MangaLib" = null;
              "ReadManga" = null;
            };
          }
        )
      );
    };
  };

  networking.firewall = {
    allowedTCPPorts = [ 8888 ];
  };
}
