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

      lowfi
      anicliru
    ];
  };
}
