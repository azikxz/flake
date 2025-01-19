{
  pkgs,
  inputs,
  ...
}:
let
  inherit (pkgs) callPackage;
in
# inherit (pkgs.nur.repos) rycee;
{
  imports = with inputs; [ nur.modules.homeManager.default ];
  module.programs = {
    gui.pkgs = with pkgs; [
      nemo # GUI FM
      nemo-fileroller # ADDON
      file-roller # ARCHIVER

      _64gram # TG GUI
      vesktop
      onlyoffice-bin # OFFICE
      qbittorrent-enhanced # QTORRENT
      filezilla # FTP CLIENT
      gnome-secrets # KEEPASS LIBADW
      keepassxc # PASSWORDS MANAGER

      popsicle # ISO WRITER
      ventoy # FUCK

      bottles # LAUNCH GAMES WITHOUT STEAM
      # mindustry-wayland # MINDUSTRY LETSSS GOOOOO
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
      tenki # CLOCK

      imagemagick # CONVERT IMG
      jpegoptim # LOW SIZE JPG
      optipng # LOW SIZE PNG
      lutgen # COLORIZE IMG

      wyvern # GOG
      hut # SOURCEHUT INTERACTION
      sd # FIND/REPLACE

      wineWow64Packages.staging # SIMPLE LAUNCHER

      # rycee.mozilla-addons-to-nix # ADDONS TO NIX
      (callPackage ./pkgs/anicli {
        verCli = "5.0.12";
        verApi = "0.7.0";
      }) # WATCH ANIME VIA TERMINAL & MPV
    ];
  };
}
