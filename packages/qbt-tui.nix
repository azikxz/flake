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
    url = "https://gist.githubusercontent.com/azikxz/830d05638b70779ddaf6e0645377a8bf/raw/1cdc546f6b1887de5951e1d739a9ade3ddf5e55d/qbitui.py";
    sha256 = "sha256-Jz/I26utoyqoMKKeMZst0lFKzXg/ee50tbEjOJy7YoI=";
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
