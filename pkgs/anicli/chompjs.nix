{
  fetchPypi,
  python3Packages,
}:

let
  setup = with python3Packages; [ setuptools ];
in

python3Packages.buildPythonApplication rec {
  pname = "chompjs";
  version = "1.3.0";
  pyproject = true;
  build-system = setup;
  dependencies = setup;

  src = fetchPypi {
    inherit pname version;
    hash = "sha256-isCzF1XpOTSPsq8cwBw1fbUMhU+j1QbOeSGPwV8FaGg=";
  };
}
