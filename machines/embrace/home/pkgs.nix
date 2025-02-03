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
      p7zip-rar
      ouch

      imagemagick
      jpegoptim

      hut
      sd

      (customPkgs "lowfi" {
        version = "1.5.6";
      }) # LO-FI RADIO
      (customPkgs "anicli" {
        verCli = "5.0.12";
        verApi = "0.7.0";
      }) # WATCH ANIME VIA TERMINAL & MPV
    ];
  };
}
