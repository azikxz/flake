{
  pkgs,
  lib,
}:

let
  pyPkgs = pkgs.python3Packages;
in
with pyPkgs;

buildPythonApplication {
  pname = "rezka-fzf";
  version = "git";

  src = pkgs.fetchurl {
    url = "https://gist.githubusercontent.com/axax-loll/09750e07b880123ccbe9010343f066ee/raw/c6cef2cd4b93af23cf6d6a7fb19a65f902145d44/rezka_fzf.py";
    sha256 = "sha256-qp2ndBm7D/ZwhEcmlzFb7MD8HmCPd2aCgKp5XMXoGu0=";
  };

  dontUnpack = true;

  propagatedBuildInputs = [
    pkgs.python3
    requests

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
  ];

  format = "other";

  installPhase = ''
    install -Dm755 $src $out/bin/rezka-fzf
  '';

  meta = {
    description = "Watch movies/series from rezka in terminal";
    homepage = "https://gist.github.com/axax-loll/09750e07b880123ccbe9010343f066ee";
    license = lib.licenses.wtfpl;
    platforms = [ "x86_64-linux" ];
    maintainers = with lib.maintainers; [ azikxz ];
    mainProgram = "rezka-fzf";
  };
}
