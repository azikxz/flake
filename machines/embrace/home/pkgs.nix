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

      (customPkgs "lowfi" { })
      (customPkgs "anicli" { })
    ];
  };
}
