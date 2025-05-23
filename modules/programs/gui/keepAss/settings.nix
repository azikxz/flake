{
  lib,
  ...
}:

let
  inherit (lib.paths)
    passwords
    ;
in

{
  Browser.Enabled = true;

  General = {
    AutoReloadOnChange = true;
    AutoSaveAfterEveryChange = true;
    AutoSaveOnExit = true;
    ConfigVersion = 2;
    LastActiveDatabase = passwords;
    LastDatabases = passwords;
    LastOpenedDatabases = passwords;
    NumberOfRememberedLastDatabases = 1;
    OpenPreviousDatabasesOnStartup = true;
    UseAtomicSaves = true;
  };

  GUI = {
    ApplicationTheme = "classic";
    ColorPasswords = true;
    CompactMode = true;
    HideGroupsPanel = true;
    HidePasswords = true;
    HidePreviewPanel = true;
    HideToolbar = true;
    MinimizeOnClose = true;
    MinimizeToTray = true;
    MonospaceNotes = true;
    ShowTrayIcon = true;
    TrayIconAppearance = "monochrome-dark";
  };

  PasswordGenerator = {
    AdvancedMode = true;
    Dashes = true;
    Length = 32;
    LowerCase = true;
    Numbers = true;
    Quotes = true;
    SpecialChars = true;
    UpperCase = true;
  };

  Security = {
    ClearClipboardTimeout = 20;
    ClearSearch = false;
    IconDownloadFallback = true;
    LockDatabaseIdle = true;
    LockDatabaseScreenLock = false;
    Security_HideNotes = true;
  };
}
