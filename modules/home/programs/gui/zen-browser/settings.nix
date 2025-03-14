{
  lib,
  config,
  ...
}:

let
  inherit (lib) optionalAttrs;
  cfg = config.module.programs.gui.zen-browser;
in

{
  profile =
    {
      "app.normandy.first_run" = false;
      "extensions.autoDisableScopes" = 0;
      "layers.acceleration.force-enabled" = true;
      "gfx.webrender.all" = true;
      "svg.context-properties.content.enabled" = true;
      "ui.key.menuAccessKeyFocuses" = false;
      # zen
      "zen.migration.version" = 1;
      "zen.tab-unloader.enabled" = false;
      "zen.urlbar.behavior" = "float";
      "zen.view.show-newtab-button-border-top" = true;
      "zen.view.show-newtab-button-top" = false;
      "zen.workspaces.hide-default-container-indicator" = false;
      "zen.workspaces.show-icon-strip" = false;
      "zen.welcome-screen.seen" = true;
    }
    // (optionalAttrs cfg.compact.enable {
      "zen.view.compact.hide-toolbar" = true;
      "zen.view.use-single-toolbar" = false;
      "zen.view.sidebar-expanded" = false;
    });
  ext = {
    "uBlock0@raymondhill.net".settings = {
      selectedFilterLists = [
        "ublock-filters"
        "ublock-badware"
        "ublock-privacy"
        "ublock-unbreak"
        "ublock-quick-fixes"
      ];
    };
    "{7a7a4a92-a2a0-41d1-9fd7-1e92480d612d}".settings = {
      dbInChromeStorage = true;
    };
  };
}
