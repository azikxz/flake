{
  pkgs,
  lib,
  config,
  ...
}:

with lib;
# INFO:
# legendary auth
# legendary list
# legendary install

mkIf (mac "pcRyazenka" || mac "thinkpadT14") {
  persist.user.dirs = [ ".config/legendary" ];

  hmPackages = [ pkgs.legendary-gl ];

  hm.xdg.configFile."legendary/config.ini".text = generators.toINI { } {
    "Legendary" = {
      disable_auto_aliasing = false;
      disable_https = false;
      disable_update_check = false;
      disable_update_notice = false;
      install_dir =
        if (mac "pcRyazenka") then "/media/disks/fastBitch/Games" else config.hm.xdg.userDirs.download;
      locale = "en-US";
      log_level = "debug";
      max_memory = 2048;
      max_workers = 8;
    };
  };
}
