{
  pkgs,
  lib,
  ...
}:

with lib;
# INFO: usage
# anicli -> anicli-ru -q 1440
#
# WARN: to use anilib auth follow this
# https://github.com/vypivshiy/anicli-api/issues/42#issuecomment-2889017544

mkIf (mac "pcRyazenka" || mac "thinkpadT14") {
  environment.systemPackages = [ pkgs.anicliru ];

  nixpkgs.overlays = [
    (final: prev: {
      anicliru =
        with prev.lib;
        prev.writeShellScriptBin "anicliru" ''${getExe pkgs.self'.anicliru} -q 1080 ${
          (
            if (pathExists ./headers.txt) then
              "--header-file ${toString (prev.writeText "headers.txt" (readFile ./headers.txt))}"
            else
              ""
          )
        }'';
    })
  ];
}
