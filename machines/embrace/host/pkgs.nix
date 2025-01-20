{
  inputs,
  pkgs,
  ...
}:
{
  imports = with inputs; [
    disko.nixosModules.default
    hardware.nixosModules.lenovo-thinkpad-t14-amd-gen1
  ];
  module.programs.common.pkgs = with pkgs; [
    helix
    killall
    openvpn
  ];
  networking.modemmanager.enable = true;
}
