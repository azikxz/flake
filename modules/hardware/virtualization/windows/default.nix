{
  lib,
  config,
  ...
}:

with lib;
let
  customIso = /media/torrents/tiny11_25H2/tiny11core_25H2_Oct25.iso;
  # only as path when local, not string
  # when url then string
  # > /media/torrents/tiny11_25H2/tiny11core_25H2_Oct25.iso
  #
  # or other windows
  # https://archive.org/download/tiny11_25H2/tiny11core_25H2_Oct25.iso # win11 25H2 core
  # https://archive.org/download/tiny11_25H2/tiny11_25H2_Oct25.iso # win11 22H2
  # https://archive.org/download/tiny-10-23-h2/tiny10%20x64%2023h2.iso # win10 23H2
in
# INFO
# 1) enable this module
# 2) wait for rebuild
# 3) watch 'systemctl status podman-windows.service'
# 4) enter to http://localhost:8006
# 5) your windows is ready
# 6) to activate windows open powershell and type
#    > iex (curl.exe -s --doh-url https://1.1.1.1/dns-query https://get.activated.win | Out-String)

mkIf (mac "pcRyazenka") {
  networking.firewall.allowedTCPPorts = [ 3389 ];

  virtualisation.oci-containers.containers = {
    # WARN: only with WinApps, not winapps cause idk

    windows = {
      autoStart = false;
      # INFO: will be sopped on boot
      # > systemctl start podman-WinApps.service
      # to start container

      image = "ghcr.io/dockur/windows:latest";

      environment = {
        "VERSION" = "tiny11"; # by default

        "CPU_CORES" = (toString 8);
        "RAM_SIZE" = (toString 8) + "G";
        "DISK_SIZE" = (toString (8 * 8)) + "G";

        "HOME" = config.hm.home.homeDirectory;
        # "PASSWORD" & "USERNAME" automatically sets from secret

        "REGION" = "en-US";
        "KEYBOARD" = "en-US";

        "GPU" = "Y";
      };

      environmentFiles = [ config.sopsnix."services/windows" ];

      volumes = [
        "${config.hm.home.homeDirectory}:/shared:rw"
        "/media:/media:rw"
      ]
      # custom local iso of windows
      ++ (optional (isPath customIso) "${toString customIso}:/custom.iso");

      devices = [ "/dev/dri" ];

      ports = [
        "8006:8006/tcp"
        "3389:3389/tcp"
        "3389:3389/udp"
      ];

      extraOptions = [
        "--device=/dev/kvm:/dev/kvm:rwm"
        "--device=/dev/net/tun:/dev/net/tun:rwm"
        "--device=/dev/dri:/dev/dri:rwm"

        "--cap-add=NET_ADMIN"

        "--network-alias=windows"
        "--privileged"
      ];
    };
  };
}
