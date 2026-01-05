{
  pkgs,
  lib,
}:

let
  version = "1.20.1-47.4.0";
  installerHash = "sha256-8/V0ZeLL3DKBk/d7p/DJTLZEBfMe1VZ1PZJ16L3Abiw=";
  localHash = "sha256-EtqyOX9REjT5sCxm2s+dhSzXnIvuFEhdFqlwgVbEugw=";
  java = pkgs.temurin-jre-bin-17 or (throw "Set Java version (as. pkgs.temurin-jre-bin)");
  args = "@libraries/net/minecraftforge/forge/1.20.1-47.4.0/unix_args.txt";

  local =
    let
      src = pkgs.fetchurl {
        url = "https://maven.minecraftforge.net/net/minecraftforge/forge/${version}/forge-${version}-installer.jar";
        hash = installerHash;
      };
    in
    pkgs.runCommand "forge-local"
      {
        outputHash = localHash;
        outputHashAlgo = "sha256";
        outputHashMode = "recursive";

        nativeBuildInputs = [ java ];
      }
      ''
        mkdir -p $out
        cd $out

        cp -v ${src} forge-installer.jar
        java -jar forge-installer.jar --installServer

        rm forge-installer.jar.log
      '';
in

pkgs.runCommand "forge" { } ''
  mkdir -pv $out/bin
  cat <<EOF > $out/bin/$name
  #!/bin/sh

  export PATH=${lib.makeBinPath [ java ]}:\$PATH

  rm libraries
  ln -svf ${local}/libraries libraries

  exec java "\$@" ${toString args} nogui
  EOF
  chmod +x $out/bin/$name
  patchShebangs $out/bin
''
