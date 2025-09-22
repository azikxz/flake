{ pkgs, lib }:

pkgs.stdenv.mkDerivation rec {
  pname = "ytid";
  version = "stable";

  dontUnpack = true;

  nativeBuildInputs = [ pkgs.makeWrapper ];

  src = pkgs.fetchurl {
    url = "https://raw.githubusercontent.com/avanssion/youtube-channel-id-finder/refs/heads/master/script.sh";
    sha256 = "sha256-o+dkwHvIQMUv8/b917jW2GpSkcp/TKM1x/WkPoGeDOA=";
  };

  installPhase = ''
    mkdir -p $out/bin
    cp $src $out/bin/${pname}
    chmod +x $out/bin/${pname}
    wrapProgram $out/bin/${pname} \
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
    maintainers = with lib.maintainers; [ azikx ];
    mainProgram = "ytid";
  };
}
