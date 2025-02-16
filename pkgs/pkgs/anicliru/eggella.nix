{ pkgs }:

pkgs.python3Packages.buildPythonApplication rec {
  pname = "eggella";
  version = "0.1.7";
  pyproject = true;

  src = pkgs.fetchPypi {
    inherit pname version;
    hash = "sha256-8Vo39BePA86wcLKs/F+u2N7tpIpPrEyEPp3POszy050=";
  };

  build-system = with pkgs.python3Packages; [
    hatchling
    setuptools
  ];

  dependencies = with pkgs.python3Packages; [
    prompt-toolkit
  ];
}
