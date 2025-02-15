{
  pkgs,
  lib,
  ...
}:

let
  inherit (lib.x) customPkgs;
in

{
  module.programs = {
    gui.pkgs = with pkgs; [
      portablemc
      qbittorrent-enhanced
      filezilla
      libreoffice-fresh

      popsicle
      ventoy

      srb2
      srb2kart
      mindustry-wayland

      bottles
      wineWow64Packages.stagingFull
    ];
    cli.pkgs = with pkgs; [
      imagemagick
      jpegoptim
      optipng
      lutgen

      cachix
      wyvern
      hut
      sd

      (customPkgs "lowfi" { })
      (customPkgs "anicli" { })
    ];
  };
}
