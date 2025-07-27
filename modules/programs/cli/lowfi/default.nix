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

mkIf false {
  environment.systemPackages = with pkgs.self'; [ lowfi ];

  hm.home.shellAliases = (
    builtins.listToAttrs (
      map
        (
          file:
          let
            name = builtins.replaceStrings [ ".txt" ] [ "" ] file;
          in
          {
            name = "lowfi-${name}";
            value = "${getExe pkgs.lowfi} -t ${./. + "/${file}"}";
          }
        )
        (
          builtins.filter (file: builtins.match ".*\\.txt$" file != null) (
            builtins.attrNames (builtins.readDir ./.)
          )
        )
    )
  );
}
