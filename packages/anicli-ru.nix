{
  pkgs,
  lib,
}:

let
  pyPkgs = pkgs.python312Packages;
in

with pyPkgs;

buildPythonApplication rec {
  pname = "anicli_ru";
  version = "6.0.2";
  pyproject = true;

  src = pkgs.fetchPypi {
    inherit
      pname
      version
      ;
    hash = "sha256-mDkXJGL0YeIYP5wKkMG56Tte284nsUEDkOxRCCn3Snc=";
  };

  build-system = with pyPkgs; [
    hatchling
  ];

  dependencies = [
    jinja2
    prompt-toolkit
    python-multipart
    rich
    segno
    typer
    fastapi

    (buildPythonApplication rec {
      pname = "anicli_api";
      version = "0.8.11";
      pyproject = true;

      src = pkgs.fetchPypi {
        inherit
          pname
          version
          ;
        hash = "sha256-Hu69ymwgsyLZKPZwzmRFU8WqRKWj/tvgXHCnHx9eeVE=";
      };

      build-system = with pyPkgs; [
        hatchling
      ];

      dependencies = [
        attrs
        httpx
        httpx.optional-dependencies.http2
        hatchling
        parsel
        tqdm
      ];
    })

    # (buildPythonApplication rec {
    #   pname = "rookiepy";
    #   version = "0.5.6";
    #   pyproject = true;

    #   src = pkgs.fetchPypi {
    #     inherit
    #       pname
    #       version
    #       ;
    #     hash = "sha256-76apOxGUeKlrPYxEVCFcTxrzFqJLOzswFbc8HB2IcHg=";
    #   };

    #   build-system = [
    #     (buildPythonApplication rec {
    #       pname = "rookiepy";
    #       version = "0.5.6";
    #       pyproject = true;

    #       src = pkgs.fetchPypi {
    #         inherit
    #           pname
    #           version
    #           ;
    #         hash = "sha256-76apOxGUeKlrPYxEVCFcTxrzFqJLOzswFbc8HB2IcHg=";
    #       };

    #       build-system = [
    #         pkgs.maturin
    #       ];
    #     })
    #   ];
    # })

    (buildPythonApplication rec {
      pname = "uvicorn";
      version = "0.40.0";
      pyproject = true;

      src = pkgs.fetchPypi {
        inherit
          pname
          version
          ;
        hash = "sha256-g5Z2Z16H5zaUUYtVdP0PJMnZe0a+oW33uMBeoaUQceo=";
      };

      build-system = with pyPkgs; [
        hatchling
      ];

      dependencies = [
        click
        h11
        typing-extensions
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
