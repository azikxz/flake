{
  pkgs,
  lib,
  ...
}:

with lib;
# INFO:
# legendary auth
# legendary list
# legendary install

mkIf (mac "pcRyazenka") {
  persist.user.dirs = [ ".config/legendary" ];

  environment.systemPackages = [ pkgs.legendary-gl ];

  hm.xdg.configFile."legendary/config.ini".text = generators.toINI { } {
    "Legendary" = {
      disable_auto_aliasing = false;
      disable_https = false;
      disable_update_check = false;
      disable_update_notice = false;
      install_dir =
        if (mac "pcRyazenka") then "/media/disks/fastBitch/Games" else config.hm.xdg.userDirs.downloads;
      locale = "en-US";
      log_level = "debug";
      max_memory = 2048;
      max_workers = 8;
    };
  };
}
