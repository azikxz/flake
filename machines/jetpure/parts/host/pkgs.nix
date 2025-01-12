{ pkgs, ... }:
{
  module.programs.common.pkgs = with pkgs; [
    helix
    killall
    openvpn
  ];
}
