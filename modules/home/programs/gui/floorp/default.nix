{
  x,
  pkgs,
  lib,
  config,
  inputs,
  ...
}:
with lib;
with x;
let
  cfg = config.module.programs.gui.floorp;
  customAddons = pkgs.callPackage ./addons.nix {
    inherit (inputs.firefox-addons.lib."x86_64-linux") buildFirefoxXpiAddon;
  };
in
{
  options = {
    module.programs.gui.floorp = {
      enable = mkBool;
    };
  };

  config = mkIf cfg.enable {
    programs.floorp = on // {
      profiles.${userName} = {
        id = 0;
        isDefault = true;
        name = "${userName}";
        extensions =
          with inputs.firefox-addons.packages."x86_64-linux";
          [
            #VERY IMPORTANT
            ublock-origin
            sponsorblock
            darkreader
            vimium-c
            censor-tracker

            # MISC
            tabcenter-reborn
            firefox-color
            stylus
            translate-web-pages
          ]
          ++ (with customAddons; [ torrserver-adder ]);
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
