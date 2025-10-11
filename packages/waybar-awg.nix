{
  pkgs,
  lib,
}:

pkgs.stdenv.mkDerivation {
  pname = "waybar-awg";
  version = "git";

  dontUnpack = true;

  buildInputs = [ pkgs.tofi ];
  # INFO: requires amneziawg
  # (awg and awg-quick)

  src = pkgs.fetchurl {
    url = "https://gist.githubusercontent.com/mctrxw/e2d48b9f7af2299ba97f2dcfbd14ed37/raw/40fe0d4b0b4eca0ba71974d7e7f187387f75b8d4/gistfile1.txt";
    sha256 = "sha256-ddjRq8WIDeDMklcHQCBud3/mUj9VdNGBD65JTC3Fpow=";
  };

  installPhase = ''
    mkdir -p $out/bin
    cp $src $out/bin/waybar-awg
    chmod +x $out/bin/waybar-awg
  '';

  meta = {
    description = "awg-quick module for waybar";
    homepage = "https://gist.githubusercontent.com/mctrxw/e2d48b9f7af2299ba97f2dcfbd14ed37";
    license = lib.licenses.unlicense;
    platforms = [ "x86_64-linux" ];
    maintainers = with lib.maintainers; [ azikx ];
    mainProgram = "waybar-awg";
  };
}
