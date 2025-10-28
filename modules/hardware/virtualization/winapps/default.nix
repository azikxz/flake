{
  pkgs,
  lib,
  config,
  ...
}:

with lib;

# INFO
# 1) enable this module
# 2) wait for rebuild
# 3) watch 'systemctl status podman-winapps.service'
# 4) enter to http://localhost:8006
# 5) your windows is ready

mkIf false {
  persist.user.files = [ ".local/share/winapps/winapps.log" ];

  networking.firewall.allowedTCPPorts = [ 3389 ];

  virtualisation.oci-containers.containers = {
    # WARN: only with WinApps, not winapps
    "WinApps" = {
      autoStart = false;

      image = "ghcr.io/dockur/windows:latest";

      environment = {
        "VERSION" = "tiny11"; # INFO: low size lightweight win11

        "CPU_CORES" = (toString 8);
        "RAM_SIZE" = (toString 8) + "G";
        "DISK_SIZE" = (toString (8 * 8)) + "G";

        "HOME" = config.hm.home.homeDirectory;
        # "PASSWORD" & "USERNAME" automatically sets from secret

        GPU = "Y";
      };

      environmentFiles = [ config.sopsnix."services/winapps" ];

      volumes = [
        "${config.hm.home.homeDirectory}:/shared:rw"
        "/media:/media:rw"
        "winapps_data:/storage:rw"
      ];

      devices = [
        "/dev/dri"
      ];

      ports = [
        "8006:8006/tcp"
        "3389:3389/tcp"
        "3389:3389/udp"
      ];

      extraOptions = [
        "--device=/dev/kvm:/dev/kvm:rwm"
        "--device=/dev/net/tun:/dev/net/tun:rwm"

        "--cap-add=NET_ADMIN"

        "--network-alias=windows"
        "--privileged"
      ];
    };
  };

  environment.systemPackages = with pkgs; [
    winapps
    winapps-launcher
  ];

  hm.xdg.configFile."winapps/winapps.conf".text = ''
    source ${config.sopsnix."services/winapps"}
  ''
  + (generators.toINIWithGlobalSection { } {
    globalSection = {
      RDP_USER = "$USER";
      RDP_PASS = "$PASSWORD";

      RDP_IP = "127.0.0.1";
      RDP_SCALE = "100";
      RDP_FLAGS = "\"/cert:tofu /sound /microphone\"";

      WAFLAVOR = config.virtualisation.oci-containers.backend;
      DEBUG = "false";

      AUTOPAUSE = "on";
      AUTOPAUSE_TIME = "300";
      FREERDP_COMMAND = "";

      REMOVABLE_MEDIA = if config.services.udisks2.mountOnMedia then "/media" else "/run/media"; # cause udisks
    };

    sections = { };
  });

  systemd = import ./systemd.nix {
    inherit
      lib
      config
      ;
  };
}
