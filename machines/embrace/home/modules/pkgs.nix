{
  pkgs,
  ...
}:

{
  module.programs = {
    gui.pkgs = with pkgs; [
      libreoffice-fresh
    ];
    cli.pkgs = with pkgs; [
      zip
      ouch

      imagemagick
      jpegoptim

      hut
      sd
    ];
  };
}
