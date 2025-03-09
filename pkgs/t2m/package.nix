{ pkgs }:

pkgs.writeShellScriptBin "t2m" (
  builtins.readFile (
    pkgs.fetchurl {
      url = "https://github.com/lbtm/torrent2magnet/raw/refs/heads/master/t2m.sh";
      sha256 = "sha256-ll8UjsInJLXiOJLEsCDeGVls434epheY5nAz8Tixwcw=";
    }
  )
)
