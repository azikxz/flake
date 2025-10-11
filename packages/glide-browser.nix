{
  pkgs,
  lib,
}:

# WARN: broken, im lazy to fixit
# auto-patchelf failed to find all the required dependencies.

pkgs.stdenv.mkDerivation (final: {
  pname = "glide-browser";
  version = "0.1.51a";

  src = pkgs.fetchurl {
    url = "https://github.com/glide-browser/glide/releases/download/${final.version}/glide.linux-x86_64.tar.xz";
    sha256 = "sha256-eQ8itn8XvFNuLypKruTLpWyzDr899lLTMBU3yN+yGeU=";
  };

  nativeBuildInputs = [
    pkgs.autoPatchelfHook
    pkgs.makeWrapper
  ];

  buildInputs = [
    pkgs.stdenv.cc.cc.lib
    pkgs.gcc.libc
    pkgs.glibc
    pkgs.libgcc
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
