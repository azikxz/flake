{ pkgs }:

pkgs.stdenv.mkDerivation rec {
  pname = "jammer";
  version = "3.41";

  src = pkgs.fetchFromGitHub {
    owner = "jooapa";
    repo = "jammer";
    rev = version;
    hash = "sha256-WM+uU4pgdobXAQK4hQ8amt+JPkubMj/dqdbhmJq44FQ=";
    fetchSubmodules = true;
  };
}
