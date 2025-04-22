{
  pkgs,
  ...
}:

{
  module.programs = {
    gui.pkgs = with pkgs; [
      libreoffice-fresh
      filezilla

      popsicle
      ventoy
    ];
    cli.pkgs = with pkgs; [
      mini-calc
      nb

      lowfi
      anicliru

      qbHelper
    ];
  };
}
