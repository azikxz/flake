{
  pkgs,
  lib,
  ...
}:

with lib;

mkIf (machine == "pcRyazenka") {
  environment.systemPackages = with pkgs; [ lowfi ];

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
