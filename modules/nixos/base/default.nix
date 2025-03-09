{
  pkgs,
  lib,
  config,
  ...
}:

with lib;
with x;
let
  cfg = config.module.base;
in

{
  options = {
    module.base = {
      enable = mkBool false;
    };
  };

  config = mkIf cfg.enable {
    services.getty.autologinUser = sys.userName;
    boot = {
      kernelPackages = with pkgs; linuxPackages_zen;
      loader = {
        systemd-boot = on // {
          configurationLimit = 4;
        };
        timeout = mkForce 0;
      };
    };
    networking = {
      hostName = sys.hostName;
      useDHCP = mkDefault true;
      nameservers = [
        "::1"
        "127.0.0.1"
        "100.100.100.100"
        "1.0.0.1"
        "1.1.1.1"
        "8.8.8.8"
      ];
    };
    security = {
      sudo = off;
      sudo-rs = on;
    };
    users = {
      users.media = {
        isSystemUser = true;
        group = "media";
      };
      groups.media = { };
    };
  };
}
