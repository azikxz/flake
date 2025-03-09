{
  pkgs,
  ...
}:

{
  module.programs = {
    gui.pkgs = with pkgs; [
      qbittorrent-enhanced
      libreoffice-fresh
      komikku

      wineWow64Packages.stagingFull
      mindustry-wayland
      srb2
    ];
    cli.pkgs = with pkgs; [
      atool
      zip
      ouch

      imagemagick
      jpegoptim

      hut
      sd

      xpk.lowfi
    ];
  };
}
