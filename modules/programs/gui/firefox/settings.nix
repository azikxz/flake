{
  profile = {
    "app.normandy.first_run" = false;
    "extensions.autoDisableScopes" = 0;
    "gfx.webrender.all" = true;
    "layers.acceleration.force-enabled" = true;
    "svg.context-properties.content.enabled" = true;
    "ui.key.menuAccessKeyFocuses" = false;
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
