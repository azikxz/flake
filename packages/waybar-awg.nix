{ pkgs }:

# thanks for https://github.com/oatmealine/nix-config/blob/c7220e519db836235c1e3159ef57e5cedfe55393/modules/software/system/amnezia.nix

pkgs.stdenv.mkDerivation rec {
  pname = "waybar-awg";
  version = "unstable";

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
    cp $src $out/bin/${pname}
    chmod +x $out/bin/${pname}
  '';

  meta.mainProgram = "waybar-awg";
}
