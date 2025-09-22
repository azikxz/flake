{ pkgs, lib }:

pkgs.stdenvNoCC.mkDerivation rec {
  pname = "wofi-bluetooth";
  version = "unstable";

  src = pkgs.fetchurl {
    url = "https://raw.githubusercontent.com/mctrxw/wofi-bluetooth/a4a0caf025fba65d94534471c36158e0e81c154f/wofi-bluetooth";
    sha256 = "sha256-EAh6UcH6EN19LX6OaamC8QNKkqQXGj7hDVV9zWKwSow=";
  };

  nativeBuildInputs = [ pkgs.makeWrapper ];
  dontUnpack = true;

  installPhase = ''
    mkdir -p $out/bin

    install -Dm755 $src $out/bin/${pname}
    chmod +x $out/bin/${pname}

    wrapProgram $out/bin/${pname} \
      --prefix PATH ':' \
        "${lib.makeBinPath (with pkgs; [ wofi ])}"
  '';

  meta = {
    description = "Control bt via wofi";
    homepage = "https://github.com/mctrxw/wofi-bluetooth";
    license = lib.licenses.gpl3;
    maintainers = with lib.maintainers; [ azikx ];
    mainProgram = pname;
  };
}
