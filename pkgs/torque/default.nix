{
  stdenv,
  fetchurl,
}:

stdenv.mkDerivation {
  name = "torque";
  dontUnpack = true;

  src = fetchurl {
    url = "https://raw.githubusercontent.com/dylanaraps/torque/refs/heads/master/torque";
    sha256 = "sha256-4PoO7Vn1/Lu2uB3UttH1PJbSMBq/dE+oJl8OoQ4YQC4=";
  };

  installPhase = ''
    mkdir -p $out/bin
    cp $src $out/bin/torque
    chmod +x $out/bin/torque
  '';
}
