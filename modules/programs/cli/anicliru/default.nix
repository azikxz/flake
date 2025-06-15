{
  pkgs,
  lib,
  ...
}:

with lib;

mkIf (itIs == "desktop" || itIs == "laptop") {
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
