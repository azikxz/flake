{
  pkgs,
  lib,
}:

pkgs.stdenv.mkDerivation rec {
  pname = "terrafirmagreg_server";
  version = "0.11.14";

  srcs = [
    (pkgs.fetchurl {
      name = "modpack.zip";
      url = "https://github.com/TerraFirmaGreg-Team/Modpack-Modern/releases/download/${version}/TerraFirmaGreg-Modern-${version}-serverpack.zip";
      sha256 = "sha256-VFyqg2u3Yko8VRWjHA8hMUm9hbkiyOVCnfJ/2IJsXLs=";
    })
  ];

  dontBuild = true;

  unpackPhase = ''
    for src in $srcs; do
      ${lib.getExe pkgs.ouch} d $src
    done
  '';

  installPhase = ''
    install -d $out
    mv *-modpack/* $out
    ls
  '';
}
