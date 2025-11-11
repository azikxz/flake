{
  pkgs,
  lib,
  ...
}:

with lib;
# INFO:
# create .txt files in ./
# for getting aliases:
# ./synthboy.txt -> lowfi-synthbow
# ./rockMetal.txt -> lowfi-rockMetal

mkIf (mac "pcRyazenka" || mac "thinkpadT14") {
  hmPackages = [ pkgs.lowfi ];

  hm.home.shellAliases = (
    listToAttrs (
      map (file: {
        name = "lowfi-${replaceStrings [ ".txt" ] [ "" ] file}";
        value = "lowfi -m -w 9 -t ${./. + "/${file}"}";
      }) (filter (file: match ".*\\.txt$" file != null) (attrNames (builtins.readDir ./.)))
    )
  );
}
