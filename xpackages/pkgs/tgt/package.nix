{ pkgs }:

with pkgs;
let
  build = builtins.attrValues {
    inherit (pkgs)
      pkg-config
      openssl
      wayland
      bzip2
      zstd
      ;
    tdlib = tdlib.overrideAttrs {
      version = "1.8.29";
      src = fetchFromGitHub {
        owner = "tdlib";
        repo = "td";
        rev = "af69dd4397b6dc1bf23ba0fd0bf429fcba6454f6";
        hash = "sha256-2RhKSxy0AvuA74LHI86pqUxv9oJZ+ZxxDe4TPI5UYxE=";
      };
    };
  };
in

pkgs.rustPlatform.buildRustPackage {
  pname = "tgt";
  version = "unstable-2024-11-04";

  doCheck = false;
  buildNoDefaultFeatures = true;
  buildFeatures = [ "pkg-config" ];

  src = pkgs.fetchFromGitHub {
    owner = "FedericoBruzzone";
    repo = "tgt";
    rev = "38768515feb890fe15df08b5f1c1306370fd647a";
    hash = "sha256-6UnvYjwizAXGL7+8MX8xNGJssHIAL9PBmhqeUHFpb3A=";
  };

  useFetchCargoVendor = true;
  cargoHash = "sha256-sEQQ6gsrbeHTfQ4AURNRMYb+kUKl9Zgw0+pHSpSlxNU=";

  nativeBuildInputs = build;
  buildInputs = build;

  patches = [
    (fetchurl {
      url = "https://raw.githubusercontent.com/FedericoBruzzone/tgt/38768515feb890fe15df08b5f1c1306370fd647a/patches/0001-check-filesystem-writability-before-operations.patch";
      sha256 = "sha256-ugztN6YAZEmpXndhMDGRPRuEOgGWS7cACXQ/Yj1soXw=";
    })
  ];

  env = {
    RUSTFLAGS = "-C link-arg=-Wl,-rpath,${tdlib}/lib -L ${pkgs.openssl}/lib";
    ZSTD_SYS_USE_PKG_CONFIG = true;
    LOCAL_TDLIB_PATH = "${tdlib}/lib";
  };
}
