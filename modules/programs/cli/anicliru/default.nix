{
  pkgs,
  lib,
  ...
}:

with lib;

mkIf (machine == "pcRyazenka" || machine == "thinkpadT14") {
  environment.systemPackages =
    with pkgs;
    [ anicliru ]
    ++ [
      (writeScriptBin "anicli" ''anicli-ru -q 1080 -s anilibme ${
        (
          if (pathExists ./headers.txt) then
            "--header-file ${toString (writeText "headers.txt" (readFile ./headers.txt))}"
          else
            ""
        )
      }'')
    ];
}
