{
  inputs,
  pkgs,
  ...
}:
{
  imports = with inputs; [ disko.nixosModules.default ];
  module.programs.common.pkgs = with pkgs; [
    helix
    killall
    openvpn
  ];
}
