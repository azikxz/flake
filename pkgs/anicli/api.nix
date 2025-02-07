{
  python3,
  fetchPypi,
  python3Packages,
  verApi ? null,
}:
python3Packages.buildPythonApplication rec {
  pname = "anicli_api";
  version = verApi;
  pyproject = true;
  dontCheckRuntimeDeps = true;

  src = fetchPypi {
    inherit pname version;
    hash = "sha256-QHuUED1htlfdLXih0Bf5HzeHn+eZBkRCKDHwAp+XILA=";
  };

  build-system = with python3Packages; [
    poetry-core
  ];

  dependencies = with python3Packages; [
    (python3.withPackages (ps: with ps; [ httpx ] ++ httpx.optional-dependencies.http2))
    attrs
    parsel
    tqdm
  ];
}
