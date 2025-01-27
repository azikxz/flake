{
  pkgs,
  fetchPypi,
  python3Packages,
  verCli ? null,
  verApi ? null,
}:
python3Packages.buildPythonApplication rec {
  pname = "anicli_ru";
  version = verCli;
  pyproject = true;

  src = fetchPypi {
    inherit pname version;
    hash = "sha256-s8uI0ch+SPqthHy+d0jcB6o5/Zqx89JHM68Q00nwCFA=";
  };

  build-system = with python3Packages; [
    hatchling
    setuptools
  ];

  dependencies = with pkgs; [
    python3Packages.hatchling
    (callPackage ./eggella.nix { })
    (callPackage ./chompjs.nix { })
    (callPackage ./api.nix { verApi = verApi; })
  ];
}
