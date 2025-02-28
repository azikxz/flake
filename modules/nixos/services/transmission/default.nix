{
  self,
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
      tui.enable = mkBool false;
    };
  };

  config = mkMerge [
    (mkIf cfg.tui.enable {
      environment.systemPackages = with pkgs; [
        self.packages.torque
        rustmission
      ];
    })
    (mkIf cfg.enable {
      systemd.services.transmission.serviceConfig.UMask = lib.mkForce "0037";
      services.transmission = on // {
        home = "/var/lib/transmission";
        downloadDirPermissions = "777";
        performanceNetParameters = true;
        openRPCPort = true;
        openPeerPorts = true;
        settings = with config.services.transmission; {
          peer-limit-per-torrent = 5;
          upload-slots-per-torrent = 2;
          download-dir = "${home}/Completed";
          incomplete-dir = "${home}/.incompleted";
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
    })
  ];
}
