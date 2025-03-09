{
  pkgs,
  ...
}:

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
      openarena
      mindustry-wayland

      bottles
      wineWow64Packages.stagingFull
    ];
    cli.pkgs = with pkgs; [
      imagemagick
      jpegoptim
      optipng
      lutgen

      mini-calc
      todo
      nb

      cachix
      wyvern
      hut
      sd

      xpk.lowfi
      xpk.anicliru
    ];
  };
}
