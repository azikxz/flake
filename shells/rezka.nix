{
  pkgs,
  lib,
}:

pkgs.mkShell {
  nativeBuildInputs = [
    (pkgs.python312.withPackages (
      packages: with packages; [
        mpv # player for work
        rich # for rich edition
        fzf # for fzf edition

        (buildPythonPackage rec {
          pname = "HdRezkaApi";
          version = "11.1.0";
          pyproject = true;

          src = pkgs.fetchPypi {
            pname = "HdRezkaApi";
            inherit version;
            hash = "sha256-ks8C+kBVI99c8CGyCMGv11ZvslKoSrBkcUXoZnNLnHU=";
          };

          dependencies = [
            requests
            beautifulsoup4
          ];

          build-system = [
            setuptools
          ];
        })
      ]
    ))
  ];

  shellHook = ''
    if command -v fish >/dev/null; then
      fish
    fi
  '';
}
