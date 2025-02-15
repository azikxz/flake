{
  lib,
  config,
  ...
}:

with lib;
with x;
let
  cfg = config.module.misc.dconf;
in

{
  options.module.misc.dconf = {
    enable = mkBool false;
  };

  config = mkIf cfg.enable {
    dconf = on // {
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
            card-backdrop = true;
            downloader-state = true;
            library-badges = [
              "unread-chapters"
              "downloaded-chapters"
              "recent-chapters"
            ];
            library-servers-logo = true;
            nsfw-only-content = true;
            servers-languages = [ "ru" ];
            system-accent-colors = true;
            page-numbering = false;
            background-color = "gray";
          };
          "${gn}/World/Secrets/last-opened-database" = {
            last-opened-database = "file://${x.path.pass}";
            generator-length = 24;
            generator-use-numbers = true;
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
            start-with-sidebar = true;
            start-with-status-bar = false;
            start-with-menu-bar = false;
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
  };
}
