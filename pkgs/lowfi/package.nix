{ pkgs }:

pkgs.rustPlatform.buildRustPackage rec {
  pname = "lowfi";
  version = "1.6.2-dev";

  src = pkgs.fetchFromGitHub {
    owner = "talwat";
    repo = "lowfi";
    rev = version;
    hash = "sha256-e0Ij3fzQEbWopj36ZG/oIDMAs8fTl6LCsJgwmyuUWz0=";
  };

  cargoHash = "sha256-R9vlj3IYEurSLy7t6tsEvHkZi6/bUnjThbBKjKy3aQY=";
  useFetchCargoVendor = true;

  nativeBuildInputs = with pkgs; [
    rustPlatform.bindgenHook
    pkg-config
  ];

  buildInputs = with pkgs; [
    alsa-lib
    openssl
  ];
}
