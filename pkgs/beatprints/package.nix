{ pkgs }:

pkgs.python3Packages.buildPythonApplication rec {
  pname = "beatprints";
  version = "1.1.3";
  pyproject = true;
  doCheck = false;
  strictDeps = false;
  pythonImportsCheck = [ "BeatPrints" ];

  src = pkgs.fetchPypi {
    inherit
      pname
      version
      ;
    hash = "sha256-qPmvZs6nQq629zp2TNhKXO6C+EJuZAD8NjcSg/p00Vg=";
  };

  build-system = with pkgs.python3Packages; [
    poetry-core
  ];

  dependencies = with pkgs.python3Packages; [
    black
    fonttools
    pillow
    questionary
    requests
    rich
    toml

    (import ./pylette.nix {
      inherit
        pkgs
        ;
    })
    (import ./lrclibapi.nix {
      inherit
        pkgs
        ;
    })
  ];
}
