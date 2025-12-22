{
  pkgs,
  lib,
}:

pkgs.stdenv.mkDerivation {
  pname = "ytid";
  version = "stable";

  dontUnpack = true;

  nativeBuildInputs = [ pkgs.makeWrapper ];

  src = pkgs.fetchurl {
    url = "https://raw.githubusercontent.com/avanssion/youtube-channel-id-finder/refs/heads/master/script.sh";
    sha256 = "sha256-o+dkwHvIQMUv8/b917jW2GpSkcp/TKM1x/WkPoGeDOA=";
  };

  installPhase = ''
    install -Dm755 $src $out/bin/ytid
    wrapProgram $out/bin/ytid \
      --prefix PATH : ${
        lib.makeBinPath [
          pkgs.curl
          pkgs.libxml2
        ]
      }
  '';

  meta = {
    description = "Get id youtube channels from url";
    homepage = "https://github.com/avanssion/youtube-channel-id-finder";
    license = lib.licenses.mit;
    platforms = [ "x86_64-linux" ];
    maintainers = with lib.maintainers; [ azikx ];
    mainProgram = "ytid";
  };
}
