{
  pkgs,
  lib,
  ...
}:

with lib;

mkIf (itIs == "desktop" || itIs == "laptop") {
  hm.home = {
    packages = [ pkgs.anicliru ];

    shellAliases.anicli = # create ./headers.txt and https://github.com/vypivshiy/anicli-api/issues/42#issuecomment-2889017544
      "anicli-ru -q 1080 -s anilibme "
      + (
        if (pathExists ./headers.txt) then
          (toString (pkgs.writeText "headers.txt" (readFile ./headers.txt)))
        else
          ""
      );
  };
}
