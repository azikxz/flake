{ pkgs }:

pkgs.python3Packages.buildPythonApplication rec {
  pname = "chompjs";
  version = "1.3.0";
  pyproject = true;

  src = pkgs.fetchPypi {
    inherit pname version;
    hash = "sha256-isCzF1XpOTSPsq8cwBw1fbUMhU+j1QbOeSGPwV8FaGg=";
  };

  build-system = with pkgs.python3Packages; [
    setuptools
    hatchling
  ];

  dependencies = with pkgs.python3Packages; [
    setuptools
    hatchling
  ];
}
