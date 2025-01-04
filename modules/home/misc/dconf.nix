{
  x,
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
    enable = mkBool;
  };

  config = mkIf cfg.enable {
    dconf = True // {
      settings =
        let
          gnome = "org/gnome/desktop";
          nemo = "org/nemo";
        in
        {
          "${gnome}/wm/preferences" = {
            button-layout = "";
          };
          "${gnome}/applications/terminal" = {
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
