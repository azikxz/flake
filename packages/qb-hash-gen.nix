{
  pkgs,
  lib,
}:

pkgs.runCommand "qb-hash-test" { } ''
  ${
    lib.getExe' (pkgs.callPackage ./qb-hash.nix {
      inherit
        pkgs
        lib
        ;
    }) "qbit-hash"
  } -e "simplepassword" >> $out
''
