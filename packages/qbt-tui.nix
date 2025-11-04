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
    url = "https://gist.githubusercontent.com/azikxz/1368b57a9dd8c5af1396d6ff94ac5395/raw/30ec85955d0b0efd7db5adadf1af392380ea6c8b/qbt-tui.py";
    sha256 = "sha256-e/4g1MJbqBKn55VIUdSh7szpH2m9s02+Kz+o02KxAYM=";
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
    homepage = "https://gist.github.com/azikz/1368b57a9dd8c5af1396d6ff94ac5395";
    license = lib.licenses.wtfpl;
    platforms = [ "x86_64-linux" ];
    maintainers = with lib.maintainers; [ azikxz ];
    mainProgram = "qbt-tui";
  };
}
