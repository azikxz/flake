{ pkgs }:

pkgs.python3Packages.buildPythonApplication rec {
  pname = "anicli_api";
  version = "0.7.3";
  pyproject = true;
  dontCheckRuntimeDeps = true;

  src = pkgs.fetchPypi {
    inherit pname version;
    hash = "sha256-eFAVr43lE+c7hFIyyKcq4W8MmzkPHdZ1z4fiYQxaHY8=";
  };

  build-system = with pkgs.python3Packages; [
    poetry-core
  ];

  dependencies = with pkgs.python3Packages; [
    (pkgs.python3.withPackages (ps: [
      h2
      socksio
      (pkgs.python3Packages.httpx.overrideAttrs {
        version = "0.27.2";
        src = pkgs.fetchFromGitHub {
          owner = "encode";
          repo = "httpx";
          tag = version;
          hash = "sha256-N0ztVA/KMui9kKIovmOfNTwwrdvSimmNkSvvC+3gpck=";
        };
      })
    ]))
    attrs
    parsel
    tqdm
  ];
}
