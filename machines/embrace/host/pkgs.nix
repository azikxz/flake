{
  inputs,
  ...
}:
{
  imports = with inputs; [
    disko.nixosModules.default
    hardware.nixosModules.lenovo-thinkpad-t14-amd-gen1
  ];
  networking.modemmanager.enable = true;
}
