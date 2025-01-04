{ fetchPypi, python3Packages }:
python3Packages.buildPythonApplication rec {
  pname = "anicli_api";
  version = "0.7.0";
  pyproject = true;
  dontCheckRuntimeDeps = true;

  src = fetchPypi {
    inherit pname version;
    hash = "sha256-LwHfxxwXxcUy1HKJfYXusz4wZCTZjQACMWQpYr9t8Vk=";
  };

  build-system = with python3Packages; [
    poetry-core
  ];

  dependencies = with python3Packages; [
    httpx
    attrs
    parsel
    tqdm
  ];
}
