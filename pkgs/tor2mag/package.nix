{ pkgs }:

pkgs.stdenv.mkDerivation {
  name = "torrent2magnet";

  src = pkgs.fetchFromGitHub {
    owner = "repolho";
    repo = "torrent2magnet";
    rev = "5e60cd1a00e072f72bbfe3d270f846c782b2a7ba";
    hash = "sha256-+83wMRwTzEjW/vfaiNHtaN8lq0shncfKPwXT89kV+Dk=";
  };

  buildInputs = [ pkgs.python3 ];

  unpackPhase = "true";
  installPhase = ''
    mkdir -p $out/bin;

    cp $src/torrent2magnet.py $out/bin/torrent2magnet
    cp $src/bencode.py        $out/bin

    chmod -x $out/bin/bencode.py
    chmod +x $out/bin/torrent2magnet
  '';
}
