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
  environment.systemPackages = with pkgs; [
    self'.anicliru

    (writeScriptBin "anicli" ''anicli-ru -q 1440 ${
      (
        if (pathExists ./headers.txt) then
          "--header-file ${toString (writeText "headers.txt" (readFile ./headers.txt))}"
        else
          ""
      )
    }'')
  ];
}
