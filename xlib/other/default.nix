{
  forAllSystems,
  self,
  inputs,
  pkgs,
  lib,
}:

{
  packages = forAllSystems (
    system:
    (import ./packages.nix {
      inherit
        self
        inputs
        pkgs
        lib
        ;
    })
  );
  devShells = forAllSystems (
    system:
    (import ./shells.nix {
      inherit
        pkgs
        ;
    })
  );
  formatter = forAllSystems (system: pkgs.nixfmt-rfc-style);
}
