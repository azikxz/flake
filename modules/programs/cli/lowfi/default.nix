{
  pkgs,
  lib,
  ...
}:

with lib;
# INFO: create .txt files in ./
# for getting aliases:
# ./synthboy.txt -> lowfi-synthbow
# ./rockMetal.txt -> lowfi-rockMetal

mkIf (mac "pcRyazenka" || mac "thinkpadT14") {
  environment.systemPackages = [ pkgs.lowfi ];

  hm.home.shellAliases = (
    builtins.listToAttrs (
      map
        (file: {
          name = "lowfi-${builtins.replaceStrings [ ".txt" ] [ "" ] file}";
          value = "lowfi -m -w 9 -t ${./. + "/${file}"}";
        })
        (
          builtins.filter (file: builtins.match ".*\\.txt$" file != null) (
            builtins.attrNames (builtins.readDir ./.)
          )
        )
    )
  );
}
