{
  x,
  ...
}:
{
  xdg = {
    configFile = {
      "keepassxc/keepassxc.ini".text = x.gen "toINI" {
        Browser = {
          Enabled = true;
        };
        Security = {
          IconDownloadFallback = true;
        };
        General = {
          ConfigVersion = 2;
        };
        GUI = {
          ApplicationTheme = "classic";
          ColorPasswords = true;
          CompactMode = true;
          HidePreviewPanel = true;
          HideUsernames = false;
          MonospaceNotes = true;
          MinimizeOnClose = true;
          MinimizeToTray = true;
          ShowTrayIcon = true;
          TrayIconAppearance = "monochrome-dark";
        };
        PasswordGenerator = {
          AdvancedMode = true;
          Dashes = true;
          Logograms = true;
          Punctuation = true;
        };
      };
    };
    dataFile = {
      "bottles/data.yml".text = x.gen "toYAML" {
        custom_bottles_path = "/mnt/HDD/Bottles";
      };
    };
  };
}
