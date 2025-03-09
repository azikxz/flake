{
  pkgs,
  lib,
  config,
  ...
}:

with lib;
with x;
let
  cfg = config.module.services.transmission;
in

{
  options = {
    module.services.transmission = {
      enable = mkBool false;
      webui = mkPkg pkgs.flood-for-transmission;
    };
  };

  config = mkIf cfg.enable {
    environment = {
      systemPackages = with pkgs; [ xpk.torque ];
      shellAliases =
        let
          mk = n: "${getExe' config.services.transmission.package n}";
        in
        {
          magn = "${mk "transmission-show"} -m";
          tAdd = "${mk "transmission-remote"} -a";
        };
    };
    systemd.services.transmission.serviceConfig.UMask = lib.mkForce "0037";
    services.transmission = on // rec {
      package = pkgs.transmission_4;
      home = "/media/torrents";
      webHome = cfg.webui;
      downloadDirPermissions = "777";
      performanceNetParameters = true;
      openRPCPort = true;
      openPeerPorts = true;
      settings = {
        peer-limit-per-torrent = 5;
        upload-slots-per-torrent = 2;
        incomplete-dir-enabled = false;
        download-dir = home;
      };
    };
    networking.hosts = {
      "163.172.167.207" = [
        "bt.t-ru.org"
        "bt2.t-ru.org"
        "bt3.t-ru.org"
        "bt4.t-ru.org"
      ];
    };
  };
}
