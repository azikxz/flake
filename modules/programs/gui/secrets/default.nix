{
  pkgs,
  lib,
  config,
  ...
}:

with lib;
let
  db = "${config.hm.xdg.userDirs.documents}/passwords/db.kdbx";
in
# INFO:
# gnome keepass frontend

mkIf false {
  hmPackages = [ pkgs.gnome-gnome-secrets ];

  hm.dconf.settings = {
    "org/gnome/World/Secrets" = {
      generator-length = 32;
      generator-use-numbers = true;
      generator-use-symbols = true;

      save-automatically = true;
      last-opened-database = "file://${db}";
      last-used-key-provider = ''{ "file://${db}": "{ }" }'';

      sort-order = "a-z";
    };
  };
}
