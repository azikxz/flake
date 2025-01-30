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
      onlyoffice-bin # OFFICE
      qbittorrent-enhanced # QTORRENT
      gnome-secrets # KEEPASS LIBADW
      komikku # MANGA READER

      wineWow64Packages.stagingFull # LAUCNCH WINDOW PROGRAMS

      mindustry-wayland # TOWER DEFENSE
      srb2 # SAWNIIICCCC
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

      hut # SOURCEHUT INTERACTION
      sd # FIND/REPLACE
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
