{ pkgs }:

pkgs.python3Packages.buildPythonPackage rec {
  pname = "pylette";
  version = "4.0.0";
  pyproject = true;
  doCheck = false;
  strictDeps = false;

  src = pkgs.fetchPypi {
    inherit pname version;
    hash = "sha256-Nw5oZasXhDZ8Xb98ZlLTWFM5eypKDOwYQdFP1FukK0A=";
  };

  build-system = with pkgs.python3Packages; [
    poetry-core
  ];

  dependencies = with pkgs.python3Packages; [
    numpy
    pillow
    requests
    scikit-learn
    typer
  ];

  pythonImportsCheck = [ "pylette" ];
}
