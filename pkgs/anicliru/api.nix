{ pkgs }:

pkgs.python3Packages.buildPythonApplication rec {
  pname = "anicli_api";
  version = "0.7.6";
  pyproject = true;
  dontCheckRuntimeDeps = true;

  src = pkgs.fetchPypi {
    inherit pname version;
    hash = "sha256-g5hGmQeTNKHmIjKgrp/n3YGCWIiPQO0ZvnMHRSEmBFc=";
  };

  build-system = with pkgs.python3Packages; [
    poetry-core
    hatchling
  ];

  dependencies =
    with pkgs.python3Packages;
    let
      httpxNew = httpx.overrideAttrs (
        finalAttrs: previousAttrs: {
          src = pkgs.fetchFromGitHub {
            owner = "encode";
            repo = previousAttrs.pname;
            tag = "0.25.2";
            hash = "sha256-rGtIrs4dffs7Ndtjb400q7JrZh+HG9k0uwHw9pRlC5s=";
          };
        }
      );
      attrsNew = attrs.overrideAttrs (
        finalAttrs: previousAttrs: {
          src = pkgs.fetchPypi {
            pname = previousAttrs.pname;
            version = "23.2.0";
            hash = "sha256-k13DtSnCYvbPduUId9NaS9PB3hlP1B9HoreujxmXHzA=";
          };
          patches = [
            (pkgs.substituteAll {
              src = pkgs.fetchurl {
                url = "https://github.com/DADA30000/dotfiles/raw/refs/heads/main/modules/system/anicli-ru/remove-hatch-plugins.patch";
                sha256 = "sha256-+WJGrSutAo+BtSrIh3V1PX0xJfoJTX3jkteYc06e6Ss=";
              };
              version = "23.2.0";
            })
          ];
        }
      );
    in
    [
      attrsNew
      httpxNew
      httpxNew.optional-dependencies.http2
    ]
    ++ [
      hatchling
      parsel
      tqdm
    ];
}
