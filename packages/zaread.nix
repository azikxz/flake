{
  pkgs,
  lib,
}:

pkgs.stdenv.mkDerivation {
  pname = "zaread";
  version = "git";

  src = pkgs.fetchurl {
    url = "https://raw.githubusercontent.com/paoloap/zaread/refs/heads/master/zaread";
    sha256 = "sha256-BvGbEvMKDx3vnuUHKCzF2/BGOVB/8Cl1P30BO24UT1I=";
  };

  nativeBuildInputs = [
    pkgs.autoPatchelfHook
    pkgs.makeWrapper
  ];

  dontUnpack = true;

  installPhase = ''
    runHook preInstall

    install -Dm755 $src $out/bin/zaread
    wrapProgram $out/bin/zaread \
      --prefix PATH ':' \
        "${
          lib.makeBinPath (
            with pkgs;
            [
              libreoffice-fresh
              zathura
              md2pdf
              file
            ]
          )
        }"

    runHook postInstall
  '';

  meta = {
    description = "A (very) lightweight MS Office file reader via zathura";
    homepage = "https://github.com/paoloap/zaread";
    license = lib.licenses.gpl3;
    platforms = [ "x86_64-linux" ];
    maintainers = with lib.maintainers; [ azikx ];
    mainProgram = "zaread";
  };
}
