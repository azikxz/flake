{
  lib,
  rustPlatform,
  fetchFromGitHub,
  pkg-config,
  openssl,
  stdenv,
  darwin,
  alsa-lib,
}:

rustPlatform.buildRustPackage {
  pname = "lowfi";
  version = "unstable-2025-02-15";

  src = fetchFromGitHub {
    owner = "talwat";
    repo = "lowfi";
    rev = "923ac05cf87c17c4283a25a25ca65d33e1693457";
    hash = "sha256-U4rTOkkEN6M2lKEXuf+xicEA2WVTqifuOpeZqFpzOEc=";
  };

  cargoHash = "sha256-lPr/qNlTBn+o/VLhqBF6mGiGf+YuSDpW44GdudmGtI4=";

  nativeBuildInputs = [
    pkg-config
    rustPlatform.bindgenHook
  ];

  buildInputs =
    [
      openssl
    ]
    ++ lib.optionals stdenv.isDarwin [
      darwin.apple_sdk.frameworks.CoreAudio
      darwin.apple_sdk.frameworks.Security
      darwin.apple_sdk.frameworks.SystemConfiguration
    ]
    ++ lib.optionals stdenv.isLinux [
      alsa-lib
    ];
}
