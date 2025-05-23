{
  profile = {
    "app.normandy.first_run" = false;
    "extensions.autoDisableScopes" = 0;
    "gfx.webrender.all" = true;
    "layers.acceleration.force-enabled" = true;
    "svg.context-properties.content.enabled" = true;
    "ui.key.menuAccessKeyFocuses" = false;

    # "zen.migration.version" = 1;
    # "zen.tab-unloader.enabled" = false;
    # "zen.urlbar.behavior" = "float";
    # "zen.view.show-newtab-button-border-top" = true;
    # "zen.view.show-newtab-button-top" = false;
    # "zen.welcome-screen.seen" = true;
    # "zen.workspaces.hide-default-container-indicator" = false;
    # "zen.workspaces.show-icon-strip" = false;

    # "zen.view.compact.hide-toolbar" = true;
    # "zen.view.sidebar-expanded" = false;
    # "zen.view.use-single-toolbar" = false;
  };

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
