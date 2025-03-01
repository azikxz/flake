{ pkgs }:

pkgs.buildGoModule rec {
  pname = "ytui";
  version = "0.2.2";

  src = pkgs.fetchFromGitHub {
    owner = "Banh-Canh";
    repo = "ytui";
    rev = "v${version}";
    hash = "sha256-SxgjyplbxevXVp4r3HOZE0odzBCtfbO3IeNXB3M+8W8=";
  };

  vendorHash = "sha256-TEOGMhGY9TdLm1awKM4e/4x2qA5bcdmHJ9mwI1zdsLI=";

  ldflags = [
    "-X=github.com/Banh-Canh/ytui/cmd.version=v${version}"
    "-s"
    "-w"
  ];
}
