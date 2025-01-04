{ pkgs, config, ... }:
{
  # THIS MODULE NEED FOR GET AN WALLPAPER
  # TROUGH LUTGEN WITH YOUR COLORSCHEME
  stylix = with pkgs; {
    image =
      let
        cfg = config.module.themes.stylix;
        img = fetchurl {
          url = cfg.image;
          sha256 = cfg.hash;
        };
      in
      runCommand "output.png" { } ''
        ${lutgen}/bin/lutgen apply ${img} -o $out -- ${
          builtins.concatStringsSep " " (
            with config.lib.stylix.colors;
            [
              base00
              base01
              base02
              base03
              base04
              base05
              base06
              base07
              base08
              base09
              base0A
              base0B
              base0C
              base0D
              base0E
              base0F
            ]
          )
        }
      '';
  };
}
