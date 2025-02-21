{ pkgs }:

pkgs.python3Packages.buildPythonApplication rec {
  pname = "anicli_ru";
  version = "5.0.15";
  pyproject = true;

  src = pkgs.fetchPypi {
    inherit pname version;
    hash = "sha256-P4dJL9V1uihNsF9mqjay3PbncjnBuKbmPhufDv5l7Uk=";
  };

  build-system = with pkgs.python3Packages; [
    hatchling
    setuptools
  ];

  dependencies = with pkgs; [
    python3Packages.hatchling
    python3Packages.setuptools
    (callPackage ./eggella.nix { })
    (callPackage ./chompjs.nix { })
    (callPackage ./api.nix { })
  ];
}
