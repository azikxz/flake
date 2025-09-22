{ pkgs, lib }:

pkgs.stdenv.mkDerivation rec {
  pname = "torrserver";
  version = "136";

  src = pkgs.fetchurl {
    url = "https://github.com/YouROK/TorrServer/releases/download/MatriX.${version}/TorrServer-linux-amd64";
    hash = "sha256-3HnKxYWCVgexYMdrgbgXVzaC+PjVJJJNs4yQ6oFo8UU=";
  };

  nativeBuildInputs = [ pkgs.autoPatchelfHook ];
  dontUnpack = true;

  installPhase = ''
    mkdir -p $out/bin
    cp $src $out/bin/torrserver
    chmod +x $out/bin/torrserver
  '';

  meta = {
    description = "Server for live watch torrets";
    homepage = "https://github.com/YouROK/TorrServer";
    license = lib.licenses.gpl3;
    maintainers = with lib.maintainers; [ azikx ];
    mainProgram = "torrserver";
  };
}
