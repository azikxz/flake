{
  pkgs,
  #
  version ? null,
  hash ? null,
}:

pkgs.python3Packages.buildPythonApplication rec {
  pname = "chompjs";
  inherit version;
  pyproject = true;

  src = pkgs.fetchPypi {
    inherit
      pname
      version
      hash
      ;
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
