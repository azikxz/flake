{
  pkgs,
  lib,
}:

# WARN: broken, im lazy to fixit
# another error:
#
# ❯ ./result/bin/glide
# fish: Job 1, './result/bin/glide' terminated by signal SIGSEGV (Address boundary error)

pkgs.stdenv.mkDerivation (final: {
  pname = "glide-browser";
  version = "0.1.52a";

  src = pkgs.fetchurl {
    url = "https://github.com/glide-browser/glide/releases/download/${final.version}/glide.linux-x86_64.tar.xz";
    sha256 = "sha256-v3bJLQ+3A4DTBIafQAMHyPdkL+71cpnQlabJYAskUgI=";
  };

  nativeBuildInputs = [
    pkgs.autoPatchelfHook
    pkgs.makeWrapper
  ];

  buildInputs = [
    pkgs.alsa-lib
    pkgs.gtk3
    pkgs.libgcc
    pkgs.libx11
  ];

  dontBuild = true;

  installPhase = ''
    mkdir -p $out/bin
    mkdir -p $out/lib/glide

    tar xf $src --directory=$out/lib/glide --strip-components=1
    chmod +x $out/lib/glide/glide-bin

    makeWrapper $out/lib/glide/glide-bin $out/bin/glide \
      --set LD_LIBRARY_PATH "${lib.makeLibraryPath final.buildInputs}"
  '';

  meta = {
    description = "An extensible and keyboard-focused web browser";
    homepage = "https://github.com/glide-browser/glide";
    license = lib.licenses.mpl20;
    platforms = [ "x86_64-linux" ];
    maintainers = with lib.maintainers; [ azikx ];
    mainProgram = "glide";
  };
})
