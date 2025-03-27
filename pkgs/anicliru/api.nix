{
  pkgs,
  #
  version ? null,
  hash ? null,
}:

pkgs.python3Packages.buildPythonApplication rec {
  pname = "anicli_api";
  inherit version;
  pyproject = true;
  dontCheckRuntimeDeps = true;

  src = pkgs.fetchPypi {
    inherit
      pname
      version
      hash
      ;
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
              src =
                let
                  git = "https://github.com/DADA30000/dotfiles/raw/refs/heads/main/";
                in
                pkgs.fetchurl {
                  url = git + "modules/system/anicli-ru/remove-hatch-plugins.patch";
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
