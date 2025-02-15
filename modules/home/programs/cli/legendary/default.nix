{
  pkgs,
  lib,
  config,
  ...
}:

with lib;
with x;
let
  cfg = config.module.programs.cli.legendary;
in

{
  options = {
    module.programs.cli.legendary = {
      enable = mkBool false;
    };
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [ legendary-gl ];
    xdg.configFile."legendary/config.ini".text = x.gen "toINI" {
      "Legendary" = {
        log_level = "debug";
        max_memory = 2048;
        max_workers = 8;
        install_dir = "/mnt/HDD/Games[LITE]";
        locale = "en-US";
        disable_https = false;
        disable_update_check = false;
        disable_update_notice = false;
        disable_auto_aliasing = false;
      };
    };
  };
}
