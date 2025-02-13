{
  x,
  pkgs,
  ...
}:
let
  inherit (x) customPkgs;
in
{
  module.programs = {
    gui.pkgs = with pkgs; [
      portablemc
      vesktop
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

      wyvern
      hut
      sd

      (customPkgs "lowfi" { })
      (customPkgs "anicli" { })
    ];
  };
}
