{
  pkgs,
  ...
}:

let
  inherit (pkgs) mkShell;
in

{
  nixDev = mkShell {
    nativeBuildInputs = with pkgs; [
      nixfmt-rfc-style
      cachix
    ];
  };
}
