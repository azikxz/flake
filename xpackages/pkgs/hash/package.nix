{ pkgs }:

pkgs.buildGoModule rec {
  pname = "hash";
  version = "1.0";

  src = pkgs.fetchFromGitHub {
    owner = "hrishiksh";
    repo = "hash";
    rev = "v${version}";
    hash = "sha256-pfHoCDK2fKTeLSONfgBV74OPzubZO8K69w9VKT9cBOg=";
  };

  vendorHash = "sha256-qibxT8ny8ruA9C6LPAlKiXS/vb8VY+1DjPQx/MUKG20=";

  ldflags = [
    "-s"
    "-w"
  ];
}
