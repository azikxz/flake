{
  AppAutoUpdate = false;
  AutofillAddressEnabled = false;
  AutofillCreditCardEnabled = false;
  BackgroundAppUpdate = false;
  CaptivePortal = false;
  DisableFirefoxScreenshots = true;
  DisableFirefoxStudies = true;
  DisableFormHistory = true;
  DisablePocket = true;
  DisableProfileRefresh = true;
  DisableSetDesktopBackground = true;
  DisableTelemetry = true;
  DisplayBookmarksToolbar = false;
  DontCheckDefaultBrowser = true;
  HardwareAcceleration = true;
  LegacyProfiles = true;
  ManualAppUpdateOnly = true;
  NetworkPrediction = false;
  OfferToSaveLoginsDefault = false;
  OfferToSaveLogins = false;
  PasswordManagerEnabled = false;
  PromptForDownloadLocation = false;

  EnableTrackingProtection = {
    Value = true;
    Locked = true;
    Cryptomining = true;
    Fingerprinting = true;
    EmailTracking = true;
  };

  SearchEngines = {
    Default = "Google";
    Remove = [
      "Bing"
      "Amazon.com"
      "eBay"
      "Twitter"
      "Wikipedia"
    ];
  };

  ExtensionSettings = {
    "*".installation_mode = "blocked";
  };

  FirefoxHome = {
    Pocket = false;
    Snippets = false;
  };

  SanitizeOnShutdown = {
    Cache = true;
    Cookies = false;
    Downloads = true;
    FormData = true;
    History = false;
    OfflineApps = true;
    Sessions = true;
  };
}
