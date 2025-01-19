{
  x,
  pkgs,
  lib,
  config,
  modulesPath,
  ...
}:
with lib;
with x;
let
  cfg = config.module.hardware.boot;
in
{
  options = {
    module.hardware.boot = {
      enable = mkBool;
      plymouth.enable = mkBool;
    };
  };

  imports = [ (modulesPath + "/installer/scan/not-detected.nix") ];
  config = mkIf cfg.enable {
    boot = {
      # ITSELF LOL
      tmp.cleanOnBoot = true;
      kernelModules = [ "kvm-amd" ];
      consoleLogLevel = 0;
      loader.efi.canTouchEfiVariables = true;
      kernelParams = [
        "quiet"
        "loglevel=3"
        "nowatchdog"
        "threadirqs"
        "pci=pcie_bus_perf"
        "boot.shell_on_fail"
        "rd.udev.log_level=3"
        "udev.log_priority=3"
        "page_alloc.shuffle=1"
        "page_alloc.shuffle=1"
        "split_lock_detect=off"
        "rd.systemd.show_status=false"
        "psmouse.synaptics_intertouch=0"
      ];
      initrd = {
        # IDK
        compressor = "zstd";
        compressorArgs = [ "-9" ];
        verbose = false;
        availableKernelModules = [
          "nvme"
          "xhci_pci"
          "ahci"
          "ohci_pci"
          "ehci_pci"
          "pata_atiixp"
          "ums_realtek"
          "sd_mod"
          "sr_mod"
          "sdhci_pci"
          "usb_storage"
        ];
      };
      plymouth = (mkIf cfg.plymouth.enable on) // {
        logo = "${pkgs.nixos-icons}/share/icons/hicolor/48x48/apps/nix-snowflake-white.png";
      };
    };
  };
}
