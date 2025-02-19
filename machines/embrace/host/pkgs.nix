{
  self,
  inputs,
  ...
}:
{
  imports = with inputs; [
    "${self}/modules/nixos/disko/default.nix"
    disko.nixosModules.default
    hardware.nixosModules.lenovo-thinkpad-t14-amd-gen1
  ];
  networking.modemmanager.enable = true;
}
