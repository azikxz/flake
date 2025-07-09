{
  pkgs,
  lib,
  ...
}:

with lib;

mkIf false {
  programs.virt-manager.enable = true;

  virtualisation = {
    spiceUSBRedirection.enable = true;

    libvirtd = {
      enable = true;

      qemu = {
        package = pkgs.qemu_kvm;

        runAsRoot = true;
        swtpm.enable = true;

        ovmf.packages = [ pkgs.OVMFFull.fd ];
      };
    };
  };

  services = {
    qemuGuest.enable = true;
    spice-vdagentd.enable = true;
  };
}
