{ pkgs, inputs, ... }:
let
  inherit (pkgs) system;
in
{
  imports = with inputs; [ nur.modules.homeManager.default ];
  module.programs = {
    gui.pkgs =
      (with pkgs; [
        nemo # GUI FM
        nemo-fileroller # ADDON
        file-roller # ARCHIVER

        _64gram # TG GUI
        vesktop
        onlyoffice-bin # OFFICE
        qbittorrent-enhanced # QTORRENT
        filezilla # FTP CLIENT
        keepassxc # PASSWORDS

        popsicle # ISO WRITER
        ventoy # FUCK

        bottles # LAUNCH GAMES WITHOUT STEAM
        # mindustry-wayland # MINDUSTRY LETSSS GOOOOO
      ])
      ++ (with inputs; [
        zen.packages.${system}.twilight # COOL BROWSER
      ]);
    cli.pkgs =
      (with pkgs; [
        nurl # FETCHER
        nix-tree # JUST COOL

        btop # CPU RAM AND PROCESSES TOP
        nvtopPackages.amd # GPU TOP

        atool # ARCHIVER
        zip # ZIP ARCHIVER
        p7zip-rar # 7ZIP
        ouch # ARCHIVE IDK

        trashy # TRASH
        tenki # CLOCK

        imagemagick # CONVERT IMG
        jpegoptim # LOW SIZE JPG
        optipng # LOW SIZE PNG
        lutgen # COLORIZE IMG

        wyvern # GOG
        tuir # REDDIT TUI
        hut # SOURCEHUT INTERACTION
        sd # FIND/REPLACE

        wineWow64Packages.staging # SIMPLE LAUNCHER
      ])
      ++ (with pkgs.nur.repos; [
        rycee.mozilla-addons-to-nix # ADDONS TO NIX
      ])
      ++ (with inputs; [
        ytcli.packages.${system}.default # YTX
      ]);
  };
}
