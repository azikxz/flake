{
  pkgs,
  lib,
  ...
}:

with lib;

mkIf false {
  environment.systemPackages = with pkgs; [
    spice
    spice-gtk
    spice-protocol
    virtio-win
    virt-viewer
    win-spice
  ];

  programs.virt-manager.enable = true;

  virtualisation = {
    spiceUSBRedirection.enable = true;

    libvirtd = {
      enable = true;

      qemu = {
        package = pkgs.qemu_kvm;

        runAsRoot = true;
        swtpm.enable = true;
      };
    };
  };

  services = {
    qemuGuest.enable = true;
    spice-vdagentd.enable = true;
  };
}
