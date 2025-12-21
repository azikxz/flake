{
  pkgs,
  lib,
  config,
  ...
}:

with lib;
let
  ini = pkgs.formats.ini { };
in
# WARN:
# i didnt yet made it for other browsers
# (only qutebrowser)

mkIf (mac "pcRyazenka" || mac "thinkpadT14") {
  hm = {
    programs.keepassxc = {
      enable = true;

      settings = import ./settings.nix;
    };

    xdg.cacheFile = {
      "keepassxc/keepassxc.ini".source = ini.generate "keepassxc-cache" {
        General =
          let
            path = "${config.hm.xdg.userDirs.documents}/passwords";
            db = "${path}/db.kdbx";
          in
          {
            LastDir = path;
            LastActiveDatabase = db;
            LastDatabases = db;
            LastOpenedDatabases = db;
          };

        GUI = {
          GroupSplitterState = "0, 965";
          ListViewState = ''@ByteArray(\0\0\0\xff\0\0\0\0\0\0\0\x1\0\0\0\0\0\0\0\x1\x1\0\0\0\x11\0\0\0\0\0\0\0\x4\0\0\0\x5\0\0\0\x6\0\0\0\a\0\0\0\b\0\0\0\t\0\0\0\n\0\0\0\v\0\0\0\f\0\0\0\x1\0\0\0\r\0\0\0\x3\0\0\0\xe\0\0\0\x2\0\0\0\xf\0\0\0\x10\0\0\0\x11\0\0\0\0\0\0\0\n\0\0\0\xe\0\0\0\f\0\0\0\x1\0\0\0\x2\0\0\0\x3\0\0\0\x4\0\0\0\x5\0\0\0\x6\0\0\0\a\0\0\0\b\0\0\0\t\0\0\0\v\0\0\0\r\0\0\0\xf\0\0\0\x10\0\0\0\x11\x63\xf7\x1\0\0\0\f\0\0\0\v\0\0\0\x64\0\0\0\x5\0\0\x1M\0\0\0\x6\0\0\0\x64\0\0\0\a\0\0\0\x64\0\0\0\0\0\0\0\x64\0\0\0\x10\0\0\0\x64\0\0\0\x2\0\0\x1M\0\0\0\x3\0\0\0\x64\0\0\0\r\0\0\0\x64\0\0\0\xf\0\0\0\x1a\0\0\0\t\0\0\0\x64\0\0\0\n\0\0\0\x1a\0\0\x2\x65\0\0\0\x11\x1\x1\0\0\0\0\0\0\0\0\0\0\0\0\0\0\x64\0\0\0\x1\0\0\0\x81\0\0\0\0\0\0\0\x11\0\0\0\0\0\0\0\x1\0\0\0\0\0\0\0\0\0\0\0\x1\0\0\0\x2\0\0\0\x1a\0\0\0\x1\0\0\0\x2\0\0\0\x1a\0\0\0\x1\0\0\0\x2\0\0\0\x8c\0\0\0\x1\0\0\0\0\0\0\0\0\0\0\0\x1\0\0\0\0\0\0\0\0\0\0\0\x1\0\0\0\0\0\0\0\xf5\0\0\0\x1\0\0\0\0\0\0\0\0\0\0\0\x1\0\0\0\0\0\0\0\0\0\0\0\x1\0\0\0\0\0\0\0\0\0\0\0\x1\0\0\0\0\0\0\0\xb0\0\0\0\x1\0\0\0\0\0\0\0\0\0\0\0\x1\0\0\0\0\0\0\0\0\0\0\0\x1\0\0\0\0\0\0\0\0\0\0\0\x1\0\0\0\0\0\0\0\0\0\0\0\x1\0\0\0\0\0\0\0\0\0\0\0\x1\0\0\0\0\0\0\x3\xe8\x1\0\0\0\x64)'';
          PreviewSplitterState = "969, 0";
          SearchViewState = "@ByteArray()";
          SplitterState = "178, 1720";
        };
      };
    };
  };

  hmMime = mkMime {
    "org.keepassxc.KeePassXC.desktop" = [
      "application/x-keepass2"
    ];
  };
}
