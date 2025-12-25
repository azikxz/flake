{
  AppAutoUpdate = false;
  AutofillAddressEnabled = false;
  AutofillCreditCardEnabled = false;
  BackgroundAppUpdate = false;
  CaptivePortal = false;
  DisableAppUpdate = true;
  DisableBuiltinPDFViewer = true;
  DisableFirefoxScreenshots = true;
  DisableFirefoxStudies = true;
  DisableFormHistory = true;
  DisableMasterPasswordCreation = true;
  DisablePasswordReveal = true;
  DisablePocket = true;
  DisableProfileRefresh = true;
  DisableSetDesktopBackground = true;
  DisableTelemetry = true;
  DisplayBookmarksToolbar = false;
  DisplayMenuBar = "never";
  DontCheckDefaultBrowser = true;
  HardwareAcceleration = true;
  LegacyProfiles = true;
  ManualAppUpdateOnly = true;
  NetworkPrediction = false;
  OfferToSaveLoginsDefault = false;
  OfferToSaveLogins = false;
  PasswordManagerEnabled = false;
  PDFjs.Enabled = false;
  PictureInPicture.Enabled = true;
  PrimaryPassword = false;
  PromptForDownloadLocation = false;
  ShowHomeButton = false;

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

  GenerativeAI = {
    Enabled = false;
    Chatbot = false;
    LinkPreviews = false;
    TabGroups = false;
    Locked = false;
  };

  SanitizeOnShutdown = {
    Cache = true;
    Cookies = false;
    Downloads = true;
    FormData = true;
    History = false;
    OfflineApps = true;
    Sessions = false;
  };
}
