{ pkgs }:

pkgs.python3Packages.buildPythonApplication rec {
  pname = "anicli_ru";
  version = "5.0.16";
  pyproject = true;

  src = pkgs.fetchPypi {
    inherit
      pname
      version
      ;
    hash = "sha256-gM9on15RQIpQVJfWW/uPeN63vSSbCJt2mNN5zkvc5Jg=";
  };

  build-system = with pkgs.python3Packages; [
    setuptools
    hatchling
  ];

  dependencies = with pkgs; [
    python3Packages.hatchling
    python3Packages.setuptools
    (callPackage ./eggella.nix {
      version = "0.1.7";
      hash = "sha256-8Vo39BePA86wcLKs/F+u2N7tpIpPrEyEPp3POszy050=";
    })
    (callPackage ./chompjs.nix {
      version = "1.3.1";
      hash = "sha256-LMXksmbp5YMH6aUjXmoDPUxCgtn6VuiBDlBXES5Ak2M=";
    })
    (callPackage ./api.nix {
      version = "0.7.13";
      hash = "sha256-hAshFd751aK3ZUP1Z+aJANtLmT955KiO1XJK+3ZNvBY=";
    })
  ];

  meta.mainProgram = "anicli-ru";
}
