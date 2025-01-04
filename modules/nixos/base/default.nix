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
      # BOOT
      kernelPackages = with pkgs; linuxPackages_zen;
      initrd.systemd = True // {
        dbus = True;
      };
      loader = {
        systemd-boot = True // {
          configurationLimit = 4;
        };
        timeout = 0;
      };
    };
    networking = {
      # NETWORKING
      hostName = hostName;
      useDHCP = mkDefault true;
      nameservers = [
        "::1"
        "127.0.0.1"
        "1.1.1.1"
        "1.0.0.1"
      ];
    };
    security = {
      # SUDO RS
      sudo = False;
      sudo-rs = True;
    };
  };
}
