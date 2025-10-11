{
  pkgs,
  lib,
}:

pkgs.stdenvNoCC.mkDerivation {
  pname = "wofi-bluetooth";
  version = "git";

  src = pkgs.fetchurl {
    url = "https://raw.githubusercontent.com/mctrxw/wofi-bluetooth/a4a0caf025fba65d94534471c36158e0e81c154f/wofi-bluetooth";
    sha256 = "sha256-EAh6UcH6EN19LX6OaamC8QNKkqQXGj7hDVV9zWKwSow=";
  };

  nativeBuildInputs = [ pkgs.makeWrapper ];
  dontUnpack = true;

  installPhase = ''
    mkdir -p $out/bin

    install -Dm755 $src $out/bin/wofi-bt
    chmod +x $out/bin/wofi-bt

    wrapProgram $out/bin/wofi-bt \
      --prefix PATH ':' \
        "${lib.makeBinPath (with pkgs; [ wofi ])}"
  '';

  meta = {
    description = "Control bt via wofi";
    homepage = "https://github.com/mctrxw/wofi-bluetooth";
    license = lib.licenses.gpl3;
    platforms = [ "x86_64-linux" ];
    maintainers = with lib.maintainers; [ azikx ];
    mainProgram = "wofi-bt";
  };
}
