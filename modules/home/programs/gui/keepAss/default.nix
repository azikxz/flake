{
  pkgs,
  lib,
  config,
  ...
}:

with lib;
with x;
let
  cfg = config.module.programs.gui.keepass;
in

{
  options = {
    module.programs.gui.keepass = {
      enable = mkBool false;
      gnome = mkBool false;
    };
  };

  config = mkIf cfg.enable {
    home.packages =
      with pkgs;
      [
        keepassxc
      ]
      ++ optional cfg.gnome [
        gnome-secrets
      ];
    xdg.configFile."keepassxc/keepassxc.ini".text = # ini
      ''
        [General]
          ConfigVersion=2
          NumberOfRememberedLastDatabases=1
        [Browser]
          CustomProxyLocation=
          Enabled=true
        [GUI]
          ApplicationTheme=classic
          ColorPasswords=true
          CompactMode=true
          MinimizeToTray=true
          ShowTrayIcon=true
          TrayIconAppearance=monochrome-dark
        [PasswordGenerator]
          AdditionalChars=
          AdvancedMode=true
          ExcludedChars=
          Length=32
        [Security]
          ClearClipboardTimeout=20
          IconDownloadFallback=true
          Security_HideNotes=true
      '';
  };
}
