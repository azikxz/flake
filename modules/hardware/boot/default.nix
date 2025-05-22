{
  pkgs,
  lib,
  ...
}:

with lib;

{
  persist.dirs = [ "/var/lib/plymouth" ];

  boot = {
    kernelPackages = pkgs.linuxPackages_zen;

    loader = {
      timeout = mkForce 0;

      systemd-boot = {
        enable = true;

        configurationLimit = 4;
      };
    };

    tmp.cleanOnBoot = true;
    kernelModules = [ "kvm-amd" ];
    consoleLogLevel = 0;
    loader.efi.canTouchEfiVariables = true;

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
        "sd_mod"
        "sdhci_pci"
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
