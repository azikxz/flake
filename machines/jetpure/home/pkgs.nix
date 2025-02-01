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
      vesktop
      qbittorrent-enhanced
      filezilla

      gnome-secrets
      keepassxc

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

      (customPkgs "lowfi" {
        version = "1.5.6";
      }) # LISTEN LO-FI
      (customPkgs "anicli" {
        verCli = "5.0.12";
        verApi = "0.7.0";
      }) # WATCH ANIME VIA TERMINAL & MPV
    ];
  };
}
