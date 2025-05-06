{
  lib,
  ...
}:

let
  inherit (lib.x.path) pass;
in

{
  Browser.Enabled = true;
  General = {
    ConfigVersion = 2;
    UseAtomicSaves = true;
    NumberOfRememberedLastDatabases = 1;
    OpenPreviousDatabasesOnStartup = true;
    AutoSaveAfterEveryChange = true;
    AutoReloadOnChange = true;
    AutoSaveOnExit = true;
    LastDatabases = pass;
    LastActiveDatabase = pass;
    LastOpenedDatabases = pass;
  };
  GUI = {
    ApplicationTheme = "classic";
    CompactMode = true;
    HidePasswords = true;
    MonospaceNotes = true;
    ColorPasswords = true;
    MinimizeOnClose = true;
    MinimizeToTray = true;
    ShowTrayIcon = true;
    TrayIconAppearance = "monochrome-dark";
  };
  PasswordGenerator = {
    Length = 32;
    AdvancedMode = true;
    LowerCase = true;
    UpperCase = true;
    Numbers = true;
    SpecialChars = true;
    Quotes = true;
    Dashes = true;
  };
  Security = {
    ClearSearch = false;
    Security_HideNotes = true;
    ClearClipboardTimeout = 20;
    IconDownloadFallback = true;
    LockDatabaseScreenLock = false;
    LockDatabaseIdle = true;
  };
}
