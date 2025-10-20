{
  pkgs,
  lib,
  config,
  ...
}:

with lib;
# INFO: usage
# anicli -> anicli-ru -q 1440
#
# WARN: to use anilib auth follow this
# https://github.com/vypivshiy/anicli-api/issues/42#issuecomment-2889017544

mkIf (mac "pcRyazenka" || mac "thinkpadT14") {
  hmPackages = [ pkgs.anicliru ];

  nixpkgs.overlays = [
    (
      final: prev: with prev.lib; {
        anicliru = prev.writeShellScriptBin "anicliru" ''
          ${getExe pkgs.anicli-ru} -q 1080 --header-file ${config.agenix.anilibme} "$@"
        '';
      }
    )
  ];
}
