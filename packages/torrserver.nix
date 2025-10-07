{ pkgs, lib }:

pkgs.stdenv.mkDerivation rec {
  pname = "torrserver";
  version = "134";

  src = pkgs.fetchurl {
    url = "https://github.com/YouROK/TorrServer/releases/download/MatriX.${version}/TorrServer-linux-amd64";
    # hash = "sha256-3HnKxYWCVgexYMdrgbgXVzaC+PjVJJJNs4yQ6oFo8UU="; # 136
    sha256 = "sha256-WDygG9aGnD20nGxtG0t+T2KEwbJ+fZ0uRaCndirrsXI=";
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
    platforms = [ "x86_64-linux" ];
    maintainers = with lib.maintainers; [ azikx ];
    mainProgram = "torrserver";
  };
}
