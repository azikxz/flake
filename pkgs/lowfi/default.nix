{
  rustPlatform,
  fetchFromGitHub,
  pkg-config,
  openssl,
  alsa-lib,
}:

rustPlatform.buildRustPackage rec {
  pname = "lowfi";
  version = "1.5.6";

  src = fetchFromGitHub {
    owner = "talwat";
    repo = "lowfi";
    rev = version;
    hash = "sha256-lR22UN9LiuJknq2KTNOXcybXwi2KvLRe0KHocFWL0GM=";
  };

  cargoHash = "sha256-lH/8n0NcGl+EagE3o9K/+wB47h4a4CwBWsZWFcoMxG0=";
  nativeBuildInputs = [
    pkg-config
    rustPlatform.bindgenHook
  ];

  buildInputs = [
    openssl
    alsa-lib
  ];
}
