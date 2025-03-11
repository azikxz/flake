{
  pkgs,
  ...
}:

{
  module.programs = {
    gui.pkgs = with pkgs; [
      qbittorrent-enhanced
      libreoffice-fresh
      zen-browser
      filezilla

      popsicle
      ventoy

      srb2
      srb2kart
      openarena
      portablemc
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
