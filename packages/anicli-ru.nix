{
  pkgs,
  lib,
}:

let
  pyPkgs = pkgs.python312Packages;

  build-system = with pyPkgs; [
    setuptools
    hatchling
    poetry-core
  ];
in
with pyPkgs;

buildPythonApplication rec {
  pname = "anicli_ru";
  version = "5.0.17";
  pyproject = true;

  src = pkgs.fetchPypi {
    inherit
      pname
      version
      ;
    hash = "sha256-TEZ/E6UUKkONSsAd3XUaRSE60tfWDgYHqN9cINGCx/I=";
  };

  inherit build-system;
  dependencies = build-system ++ [
    (buildPythonApplication rec {
      pname = "eggella";
      version = "0.1.7";
      pyproject = true;

      src = pkgs.fetchPypi {
        inherit pname version;
        hash = "sha256-8Vo39BePA86wcLKs/F+u2N7tpIpPrEyEPp3POszy050=";
      };

      inherit build-system;
      dependencies = [
        prompt-toolkit
      ];
    })

    (buildPythonApplication rec {
      pname = "anicli_api";
      version = "0.7.17";
      pyproject = true;

      src = pkgs.fetchPypi {
        inherit pname version;
        hash = "sha256-nrv3JQaYSjZTCDbwBc/7/oYurJcJKFyVlzTfO9xz1qg=";
      };

      inherit build-system;
      dependencies = [
        attrs
        httpx
        httpx.optional-dependencies.http2
        hatchling
        parsel
        tqdm
      ];
    })
  ];

  meta = {
    description = "Watch anime with ru sources via mpv";
    homepage = "https://github.com/vypivshiy/ani-cli-ru";
    license = lib.licenses.gpl3;
    maintainers = with lib.maintainers; [
      avanssion
      azikx
    ];
    mainProgram = "anicli-ru";
  };
}
