{ pkgs }:

pkgs.python3Packages.buildPythonApplication rec {
  pname = "anicli_ru";
  version = "5.0.15";
  pyproject = true;

  src = pkgs.fetchPypi {
    inherit pname version;
    hash = "sha256-UaV781K0AfXwGoRPxLDSEFL7YG1Bp+OxCoxtVCwu90o=";
  };

  build-system = with pkgs.python3Packages; [
    setuptools
    hatchling
  ];

  dependencies = with pkgs; [
    python3Packages.hatchling
    python3Packages.setuptools
    (callPackage ./eggella.nix { })
    (callPackage ./chompjs.nix { })
    (callPackage ./api.nix { })
  ];

  meta.mainProgram = "anicli-ru";
}
