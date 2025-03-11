{ pkgs }:

pkgs.python3Packages.buildPythonApplication rec {
  pname = "lrclibapi";
  version = "0.3.1";
  pyproject = true;
  doCheck = false;
  strictDeps = false;

  src = pkgs.fetchPypi {
    inherit pname version;
    hash = "sha256-a8RXcl+w/Ju4k57a8RLAx5mXUExU6cBBEsF0AwaogIg=";
  };

  build-system = with pkgs.python3Packages; [
    poetry-core
  ];

  dependencies = with pkgs.python3Packages; [
    requests
  ];

  pythonImportsCheck = [ "lrclibapi" ];
}
