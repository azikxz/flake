{
  x,
  pkgs,
  inputs,
  ...
}:
let
  inherit (x) customPkgs;
in
{
  imports = with inputs; [ nur.modules.homeManager.default ];
  module.programs = {
    gui.pkgs = with pkgs; [
      vesktop # DISCORD FOR FEMBOYS
      qbittorrent-enhanced # QTORRENT
      filezilla # FTP CLIENT
      gnome-secrets # KEEPASS LIBADW
      libreoffice-fresh # GOOD OFFICE

      popsicle # ISO WRITER
      ventoy # FUCK

      srb2 # SAWNICC
      srb2kart # SAWNICC KARTING YEEE
      mindustry-wayland # MINDUSTRY LETSSS GOOOOO

      bottles # LAUNCH GAMES WITHOUT STEAM
      wineWow64Packages.stagingFull # WINE IS NOT EMO
    ];
    cli.pkgs = with pkgs; [
      nurl # FETCHER
      nix-tree # JUST COOL

      btop # CPU RAM AND PROCESSES TOP
      nvtopPackages.amd # GPU TOP

      atool # ARCHIVER
      zip # ZIP ARCHIVER
      p7zip-rar # 7ZIP
      ouch # ARCHIVE IDK

      trashy # TRASH

      imagemagick # CONVERT IMG
      jpegoptim # LOW SIZE JPG
      optipng # LOW SIZE PNG
      lutgen # COLORIZE IMG

      wyvern # GOG
      hut # SOURCEHUT INTERACTION
      sd # FIND/REPLACE

      # rycee.mozilla-addons-to-nix # ADDONS TO NIX
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
