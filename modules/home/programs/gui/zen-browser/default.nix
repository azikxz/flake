{
  pkgs,
  lib,
  config,
  ...
}:

with lib;
with x;
let
  cfg = config.module.programs.gui.zen-browser;
in

{
  options = {
    module.programs.gui.zen-browser = {
      enable = mkBool false;
    };
  };

  imports = [ ./module.nix ];
  config = mkIf cfg.enable {
    programs.zen-browser = on // {
      profiles.${x.sys.userName} = {
        extensions = {
          force = true;
          packages =
            with pkgs.nur.repos.rycee.firefox-addons;
            let
              custom = pkgs.callPackage ./addons.nix {
                inherit
                  lib
                  buildFirefoxXpiAddon
                  ;
              };
            in
            [
              ublock-origin
              sponsorblock
              darkreader
              vimium-c
              censor-tracker
              #
              tabcenter-reborn
              firefox-color
              stylus
              translate-web-pages
            ]
            ++ (with custom; [ torrserver-adder ]);
          settings = {
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
        };
      };
      policies = {
        CaptivePortal = false;
        DisableFirefoxStudies = true;
        DisablePocket = true;
        DisableTelemetry = true;
        DisableFormHistory = true;
        DisplayBookmarksToolbar = false;
        DontCheckDefaultBrowser = true;
        DisableProfileRefresh = true;
        PromptForDownloadLocation = false;
        NetworkPrediction = false;
        showSearchBar = true;
        DisableSetDesktopBackground = true;
        LegacyProfiles = true;
        ManualAppUpdateOnly = true;
        DisableFirefoxScreenshots = true;
        HardwareAcceleration = true;
        PasswordManagerEnabled = true;
        ExtensionSettings = {
          "*".installation_mode = "blocked";
        };
        FirefoxHome = {
          Pocket = false;
          Snippets = false;
        };
        SanitizeOnShutdown = {
          Cache = true;
          History = false;
          Cookies = false;
          Downloads = true;
          FormData = true;
          Sessions = true;
          OfflineApps = true;
        };
      };
    };
  };
}
