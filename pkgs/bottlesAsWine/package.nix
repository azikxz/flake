{ pkgs }:

pkgs.writeShellScriptBin "m2tm" ''
  bottles-cli run -b MyBottle -e "$@"
''
