{
  pkgs,
  lib,
  config,
  ...
}:

with lib;
# INFO: qbittorrent cli for service
# qbt

mkIf config.services.qbittorrent.enable {
  environment.systemPackages = [ pkgs.qbittorrent-cli ];

  hm.home.file = {
    ".qbt/settings.json".text = {
      Url = "http://localhost:8080";

      Username = "pirate";
      Password = "spRAI+w8UcTTURyl7jGwkfT3caXlxQNozd8yoK25HAo=";
    };
  };
}
