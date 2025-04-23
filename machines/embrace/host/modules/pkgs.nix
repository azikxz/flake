{
  inputs,
  ...
}:
{
  imports = with inputs; [
    (import ../../../../modules/nixos/disko/default.nix { device = "/dev/nvme0n1"; })
    disko.nixosModules.default
    hardware.nixosModules.lenovo-thinkpad-t14-amd-gen1
  ];
  networking.modemmanager.enable = true;
}
