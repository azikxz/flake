{
  pkgs,
  lib,
}:

let
  pyPkgs = pkgs.python3Packages;
in
with pyPkgs;

buildPythonApplication {
  pname = "qbittorrent-tui";
  version = "git";

  src = pkgs.fetchurl {
    url = "https://gist.githubusercontent.com/mctrxw/1368b57a9dd8c5af1396d6ff94ac5395/raw/c2b62030f81ab7ea38d4feaedf91a0ab4a43bc31/qbt-tui.py";
    sha256 = "sha256-1gAYAAUyjifwOQKM2Ix1QBFnw90tuUxXlKORGIZJzbA=";
  };

  dontUnpack = true;

  propagatedBuildInputs = [
    pkgs.python3
    urwid
    requests
  ];

  format = "other";

  installPhase = ''
    mkdir -p $out/bin
    cp $src $out/bin/qbtui
    chmod +x $out/bin/qbtui
  '';

  meta = {
    description = "Control qBittorrent via TUI";
    homepage = "https://gist.github.com/mctrxw/1368b57a9dd8c5af1396d6ff94ac5395";
    license = lib.licenses.wtfpl;
    platforms = [ "x86_64-linux" ];
    maintainers = with lib.maintainers; [ azikx ];
    mainProgram = "qbt-tui";
  };
}
