{
  x,
  inputs,
  pkgs,
  lib,
  config,
  ...
}:
let
  inherit (inputs) design;
  inherit (pkgs) lutgen runCommand;
  inherit (lib) getExe;
  img = "${design}/wallpapers/${x.image}.jpg";
in
{
  stylix.image = runCommand "output.png" { } ''
    ${getExe lutgen} apply ${img} -o $out -- ${
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
}
