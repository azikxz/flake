{ pkgs }:

pkgs.rustPlatform.buildRustPackage {
  pname = "lowfi";
  version = "unstable-2025-02-15";

  src = pkgs.fetchFromGitHub {
    owner = "talwat";
    repo = "lowfi";
    rev = "923ac05cf87c17c4283a25a25ca65d33e1693457";
    hash = "sha256-U4rTOkkEN6M2lKEXuf+xicEA2WVTqifuOpeZqFpzOEc=";
  };

  useFetchCargoVendor = true;
  cargoHash = "sha256-GPQ2O0agNAQ01MEzLTzK3mJHmBrtg5OjgyI9YOLp7FU=";

  nativeBuildInputs = with pkgs; [
    pkg-config
    rustPlatform.bindgenHook
  ];

  buildInputs = with pkgs; [
    openssl
    alsa-lib
  ];
}
