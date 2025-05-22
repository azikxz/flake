{
  lib,
  ...
}:

with lib;

mkIf (itIs == "desktop" || itIs == "laptop") {
  hm.dconf = {
    settings =
      let
        gn = "org/gnome";
        gnDesk = gn + "/desktop";
        nemo = "org/nemo";
      in
      {
        "io/bassi/Amberol" = {
          background-play = true;
          enable-recoloring = true;
          replay-gain = "track";
        };

        "info/febvre/Komikku" = {
          library-badges = [
            "unread-chapters"
            "downloaded-chapters"
            "recent-chapters"
          ];

          background-color = "gray";
          card-backdrop = true;
          downloader-state = true;
          library-servers-logo = true;
          nsfw-only-content = true;
          page-numbering = false;
          servers-languages = [ "ru" ];
          system-accent-colors = true;
        };

        "${gn}/World/Secrets/last-opened-database" = {
          generator-length = 24;
          generator-use-numbers = true;
          last-opened-database = "file://${paths.passwords}";
        };

        "${gnDesk}/wm/preferences" = {
          button-layout = "";
        };

        "${gnDesk}/applications/terminal" = {
          exec = "kitty";
        };

        # nemo configuration
        "${nemo}/icon-view" = {
          default-zoom-level = "larger";
          captions = [
            "none"
            "none"
            "none"
          ];
        };

        "${nemo}/window-state" = {
          network-expanded = false;
          start-with-menu-bar = false;
          start-with-sidebar = true;
          start-with-status-bar = false;
        };

        "${nemo}/preferences" = {
          disable-menu-warning = true;
          show-computer-icon-toolbar = true;
          show-edit-icon-toolbar = false;
          show-home-icon-toolbar = true;
          show-icon-view-icon-toolbar = false;
          show-list-view-icon-toolbar = false;
          show-next-icon-toolbar = false;
          show-previous-icon-toolbar = false;
          show-search-icon-toolbar = false;
          show-up-icon-toolbar = false;
          thumbnail-limit = "2147483648";
        };
      };
  };
}
