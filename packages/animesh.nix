{
  pkgs,
  lib,
}:

pkgs.stdenv.mkDerivation (final: {
  pname = "animesh";
  version = "0.2.3";
  src = pkgs.fetchurl {
    url = "https://github.com/Abhi-Gautam/animesh/releases/download/v${final.version}/animesh-linux.tar.gz";
    sha256 = "sha256-1Q5DjDMsT8vqW8EEs+V0ox/vCuruO2LyioeyOowQPA4=";
  };

  nativeBuildInputs = [ pkgs.autoPatchelfHook ];

  buildInputs = [
    pkgs.openssl
    pkgs.libgcc
  ];

  unpackPhase = ''
    mkdir -p unpacked
    cd unpacked
    tar -xzf $src
  '';

  installPhase = ''
    mkdir -p $out/bin
    cp animesh $out/bin/
    chmod +x $out/bin/animesh
  '';

  meta = {
    description = "A CLI tool for track anime schedules";
    homepage = "https://github.com/Abhi-Gautam/animesh";
    license = lib.licenses.mit;
    platforms = [ "x86_64-linux" ];
    maintainers = with lib.maintainers; [ azikx ];
    mainProgram = "animesh";
  };
})
