{ pkgs }:

pkgs.stdenv.mkDerivation rec {
  pname = "obsidian-minimal";
  version = "8.0.1";

  src = pkgs.fetchFromGitHub {
    owner = "kepano";
    repo = "obsidian-minimal";
    rev = version;
    sha256 = "sha256-9FHkJ47R+cy2Pq62OuUUZQLSxd929xUIsQcpFGb4rso=";
  };

  phases = [ "installPhase" ];

  installPhase = ''
    mkdir -p $out
    cp $src/theme.css $out
    cp $src/manifest.json $out
    ln -s $out/theme.css $out/obsidian.css
  '';
}
