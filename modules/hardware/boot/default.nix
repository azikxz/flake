{
  pkgs,
  lib,
  ...
}:

with lib;
# INFO:
# just boot with plymouth

{
  persist.dirs = [ "/var/lib/plymouth" ];

  boot = {
    kernelPackages = mkDefault pkgs.linuxPackages_zen;

    loader = {
      timeout = mkForce 1;
      efi.canTouchEfiVariables = true;

      systemd-boot = {
        enable = true;

        configurationLimit = 4;
      };
    };

    tmp.cleanOnBoot = true;
    consoleLogLevel = 0;

    kernelModules = [
      "kvm-amd"
      "tun"
      "tap"
    ];

    kernelParams = [
      "boot.shell_on_fail"
      "loglevel=3"
      "nowatchdog"
      "page_alloc.shuffle=1"
      "page_alloc.shuffle=1"
      "pci=pcie_bus_perf"
      "psmouse.synaptics_intertouch=0"
      "quiet"
      "rd.systemd.show_status=false"
      "rd.udev.log_level=3"
      "split_lock_detect=off"
      "threadirqs"
      "udev.log_priority=3"
    ];

    initrd = {
      verbose = false;

      compressor = "zstd";
      compressorArgs = [ "-16" ];

      kernelModules = [
        "ahci"
        "ehci_pci"
        "nvme"
        "ohci_pci"
        "pata_atiixp"
        "sdhci_pci"
        "sd_mod"
        "sr_mod"
        "ums_realtek"
        "usb_storage"
        "xhci_pci"
      ];
    };

    plymouth = {
      enable = true;

      logo =
        let
          path = "${pkgs.nixos-icons}/share/icons/hicolor/48x48/apps/";
        in
        path + "nix-snowflake-white.png";
    };
  };
}
