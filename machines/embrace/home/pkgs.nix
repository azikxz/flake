{
  pkgs,
  inputs,
  ...
}:
let
  inherit (pkgs) callPackage;
in
{
  module.programs = {
    gui.pkgs = with pkgs; [
      nemo # GUI FM
      nemo-fileroller # ADDON
      file-roller # ARCHIVER

      _64gram # TG GUI
      onlyoffice-bin # OFFICE
      qbittorrent-enhanced # QTORRENT
      gnome-secrets # KEEPASS LIBADW
    ];
    cli.pkgs =
      let
        call = name: callPackage ./pkgs/${name};
      in
      with pkgs;
      [
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
        (call "lowfi" { }) # LO-FI RADIO
        (call "anicli" {
          verCli = "5.0.12";
          verApi = "0.7.0";
        }) # WATCH ANIME VIA TERMINAL & MPV
      ];
  };
}
