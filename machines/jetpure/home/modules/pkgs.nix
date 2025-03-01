{
  self,
  inputs,
  pkgs,
  ...
}:

let
  s = self.packages.${pkgs.system};
  ytx = inputs.yt-x.packages."${pkgs.system}".default;
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

      mini-calc
      todo
      nb

      cachix
      wyvern
      hut
      sd

      ytx
      s.lowfi
      s.anicliru
    ];
  };
}
