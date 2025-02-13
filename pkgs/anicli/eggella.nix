{
  fetchPypi,
  python3Packages,
}:

python3Packages.buildPythonApplication rec {
  pname = "eggella";
  version = "0.1.7";
  pyproject = true;

  src = fetchPypi {
    inherit pname version;
    hash = "sha256-8Vo39BePA86wcLKs/F+u2N7tpIpPrEyEPp3POszy050=";
  };

  build-system = with python3Packages; [
    hatchling
    setuptools
  ];

  dependencies = with python3Packages; [
    prompt-toolkit
    rich
    typer
  ];
}
