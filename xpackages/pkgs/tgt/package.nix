{ pkgs }:

with pkgs;
let
  rLinkLibs = builtins.attrValues {
    inherit (pkgs) pkg-config openssl;
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
    rev = "39fb4acec241e2db384e268c77e875bd13a48c12";
    sha256 = "sha256-McZEnRwtGEuhDA1uJ1FgUl6QiPfzCDr/Pl2haF9+MRw=";
  };

  cargoHash = "sha256-WIs9rVhTQn217DHIw1SPnQrkDtozEl2jfqVjTwJHF2w=";
  nativeBuildInputs = rLinkLibs;
  buildInputs = rLinkLibs;

  patches = [
    (fetchurl {
      url = "https://github.com/FedericoBruzzone/tgt/raw/refs/heads/main/patches/0001-check-filesystem-writability-before-operations.patch";
      sha256 = "sha256-ugztN6YAZEmpXndhMDGRPRuEOgGWS7cACXQ/Yj1soXw=";
    })
  ];

  env = {
    RUSTFLAGS = "-C link-arg=-Wl,-rpath,${tdlib}/lib -L ${pkgs.openssl}/lib";
    LOCAL_TDLIB_PATH = "${tdlib}/lib";
  };
}
