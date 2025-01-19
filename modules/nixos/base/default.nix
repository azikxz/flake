{
  x,
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
      enable = mkBool;
    };
  };

  config = mkIf cfg.enable {
    services.getty.autologinUser = userName; # AUTOLOGIN
    boot = {
      kernelPackages = with pkgs; linuxPackages_zen;
      loader = {
        systemd-boot = on // {
          configurationLimit = 4;
        };
        timeout = 0;
      };
    };
    networking = {
      hostName = hostName;
      useDHCP = mkDefault true;
      nameservers = [
        "::1"
        "127.0.0.1"
        "1.0.0.1"
        "1.1.1.1"
        "8.8.8.8"
      ];
    };
    security = {
      sudo = off;
      sudo-rs = on;
    };
  };
}
