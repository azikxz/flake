{ pkgs, lib }:

pkgs.rustPlatform.buildRustPackage rec {
  pname = "countryfetch";
  version = "0.1.9";

  src = pkgs.fetchFromGitHub {
    owner = "nik-rev";
    repo = "countryfetch";
    tag = "v${version}";
    hash = "sha256-KdFgY54vXLmq6IZfJzZ1IeZ2eQuNJoCRZUV3rVuPpcY=";
  };

  postPatch = ''
    find -name Cargo.toml -exec sed -i '1icargo-features = ["edition2024"]' {} \;
    ${lib.getExe' pkgs.yq "tomlq"} -ti '.dependencies.openssl.features[] |= select(.!="vendored")' countryfetch/Cargo.toml
  '';

  cargoHash = "sha256-XJI9k/5hdak8p0/J/x9u6lqJu/DIbX93Wwm3LALkAAw=";
  useFetchCargoVendor = true;

  env.RUSTC_BOOTSTRAP = 1;

  nativeBuildInputs = [ pkgs.pkg-config ];
  buildInputs = [ pkgs.openssl ];

  cargoBuildFlags = [ "--package=countryfetch" ];
  nativeInstallCheckInputs = [ pkgs.versionCheckHook ];
  versionCheckProgramArg = "--version";
  doInstallCheck = true;

  passthru.updateScript = pkgs.nix-update-script { };
}
