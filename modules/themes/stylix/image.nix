{
  inputs,
  pkgs,
  lib,
  config,
  ...
}:

pkgs.runCommand "output.png" { } (
  lib.concatStringsSep " " [
    (lib.getExe pkgs.lutgen)
    "apply"
    inputs.wallpapers.${lib.style.image}
    "-o"
    "$out"
    "--"
    (builtins.concatStringsSep " " config.lib.stylix.colors.toList)
  ]
)
