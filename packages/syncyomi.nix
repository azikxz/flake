{
  pkgs,
  lib,
}:

pkgs.buildGoModule rec {
  pname = "syncyomi";
  version = "1.1.4";

  src = pkgs.fetchFromGitHub {
    owner = "SyncYomi";
    repo = "SyncYomi";
    tag = "v${version}";
    hash = "sha256-pU3zxzixKoYnJsGpfvC/SVWIu0adsaiiVcLn0IZe64w=";
  };

  vendorHash = "sha256-fzPEljXFskr1/qzTsnASFNNc+8vA7kqO21mhMqwT44w=";

  web = pkgs.stdenvNoCC.mkDerivation rec {
    name = "${pname}-web-${version}";
    sourceRoot = "${src.name}/web";

    inherit
      src
      ;

    pnpmDeps = pkgs.fetchPnpmDeps {
      inherit
        pname
        version
        src
        sourceRoot
        ;

      fetcherVersion = 1;
      hash = "sha256-73aPBY4WYuZf6s9aw8yOLszW4lspVn0/axNzfYBUiG8=";
    };

    nativeBuildInputs = with pkgs; [
      nodejs
      pnpm
      pnpmConfigHook
    ];

    env.ESBUILD_BINARY_PATH = lib.getExe (
      pkgs.esbuild.override {
        buildGoModule =
          args:
          pkgs.buildGoModule (
            args
            // rec {
              version = "0.19.11";
              src = pkgs.fetchFromGitHub {
                owner = "evanw";
                repo = "esbuild";
                rev = "v${version}";
                hash = "sha256-NUwjzOpHA0Ijuh0E69KXx8YVS5GTnKmob9HepqugbIU=";
              };
              vendorHash = "sha256-+BfxCyg0KkDQpHt/wycy/8CTG6YBA/VJvJFhhzUnSiQ=";
            }
          );
      }
    );

    buildPhase = ''
      runHook preBuild
      pnpm build
      runHook postBuild
    '';

    installPhase = ''
      runHook preInstall
      cp -r dist $out
      runHook postInstall
    '';
  };

  preConfigure = ''
    cp -r $web/* web/dist
  '';

  ldflags = [
    "-s"
    "-w"
  ];

  postInstall = lib.optionalString (!pkgs.stdenvNoCC.hostPlatform.isDarwin) ''
    mv $out/bin/SyncYomi $out/bin/syncyomi
  '';

  passthru.updateScript = pkgs.nix-update-script { };

  meta = {
    description = "Open-source project to synchronize Tachiyomi manga reading progress and library across multiple devices";
    homepage = "https://github.com/SyncYomi/SyncYomi";
    license = lib.licenses.gpl2Only;
    platforms = lib.platforms.linux ++ lib.platforms.darwin;
    maintainers = with lib.maintainers; [ unazikx ];
    mainProgram = "syncyomi";
  };
}
